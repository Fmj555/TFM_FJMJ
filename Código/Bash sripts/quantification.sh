#!/bin/bash

# -------------------------------
# RNA-Seq Analysis Pipeline (STAR + FeatureCounts)
# Autor: Francisco Javier Morilla Jiménez
# Descripción: Alineamiento con STAR y cuantificación con FeatureCounts
# -------------------------------

# Configuración inicial
THREADS=6                         # Número de hilos para STAR y FeatureCounts
GENOME_DIR="genome_index"          # Carpeta donde se guardará el índice del genoma
GENOME_FASTA="/mnt/c/Users/Trvpe/PycharmProjects/JupyterProject/TFM/TFM/S_lycopersicum_chromosomes.4.00.fa.gz" # Archivo FASTA del genoma de referencia
GTF_FILE="/mnt/c/Users/Trvpe/PycharmProjects/JupyterProject/TFM/TFM/Solanum_lycopersicum.SL3.0.60.gtf"          # Archivo GTF con anotaciones
READS_DIR="clean_reads"                  # Carpeta con los archivos FASTQ.GZ
OUTPUT_DIR="alignment_results"     # Carpeta donde se guardarán los alineamientos
COUNTS_FILE="SL4_counts.txt"           # Archivo de salida de FeatureCounts

# Crear carpetas de salida si no existen
mkdir -p $GENOME_DIR $OUTPUT_DIR

# Descomprimir el archivo FASTA si está en formato .gz
if [[ $GENOME_FASTA == *.gz ]]; then
    echo "🗜️ Descomprimiendo archivo de genoma..."
    gunzip -c $GENOME_FASTA > "${GENOME_FASTA%.gz}"
    GENOME_FASTA="${GENOME_FASTA%.gz}"
fi

# Indexación del genoma con STAR (si no existe)
if [ ! -d "$GENOME_DIR/SA" ]; then
    echo " Generando índice del genoma..."
    STAR --runMode genomeGenerate --genomeDir $GENOME_DIR \
         --genomeFastaFiles $GENOME_FASTA --sjdbGTFfile $GTF_FILE \
         --runThreadN $THREADS \
         --genomeSAindexNbases 13
fi

#  Alineamiento con STAR
for file in $READS_DIR/*_R1_clean.fastq.gz; do
    sample=$(basename "$file" "_R1_clean.fastq.gz")
    echo " Alineando muestra: $sample"

    STAR --genomeDir $GENOME_DIR \
         --readFilesIn "$READS_DIR/${sample}_R1_clean.fastq.gz" "$READS_DIR/${sample}_R2_clean.fastq.gz" \
         --readFilesCommand zcat \
         --outFileNamePrefix "$OUTPUT_DIR/${sample}_" \
         --runThreadN $THREADS \
         --outSAMtype BAM SortedByCoordinate
done


#  Cuantificación con FeatureCounts
echo "Contando lecturas por gen..."
featureCounts -T $THREADS -p -a $GTF_FILE -o $COUNTS_FILE $OUTPUT_DIR/*_Aligned.sortedByCoord.out.bam

echo "✅ ¡Análisis completado! Resultados en $COUNTS_FILE"

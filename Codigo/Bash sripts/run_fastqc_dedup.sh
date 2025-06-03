# Script: run_fastqc.sh
# Descripción: Ejecuta FastQC solo en archivos FASTQ.GZ que aún no han sido analizados.

# Crear directorio de salida si no existe
mkdir -p QC_reports_dedup2

# Directorio con las lecturas limpias
READS_DIR="/mnt/c/Users/Trvpe/PycharmProjects/JupyterProject/TFM/TFM/cleaned_reads2"

# Ejecutar FastQC solo en archivos que no tengan reporte aún
for fq in "$READS_DIR"/*.fastq.gz; do
    base=$(basename "$fq" .fastq.gz)
    report="QC_reports_cleaned/${base}_fastqc.zip"

    if [ ! -f "$report" ]; then
        echo "Procesando: $fq"
        fastqc "$fq" -o QC_reports_dedup2/
    else
        echo "Ya existe reporte para: $fq"
    fi
done

echo "FastQC completado solo en archivos pendientes. Revisa los reportes en QC_reports_cleaned/."


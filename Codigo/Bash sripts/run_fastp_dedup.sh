# Crear directorios de salida si no existen
mkdir -p cleaned_reads2
mkdir -p fastp_reports2

# Bucle para procesar todos los archivos *_1.fastq.gz
for file in /mnt/c/Users/Trvpe/PycharmProjects/JupyterProject/TFM/TFM/cleaned_reads/*_R1_clean.fastq.gz; do
    sample=$(basename "$file" _R1_clean.fastq.gz)

    fastp \
        -i "/mnt/c/Users/Trvpe/PycharmProjects/JupyterProject/TFM/TFM/cleaned_reads/${sample}_R1_clean.fastq.gz" \
        -I "/mnt/c/Users/Trvpe/PycharmProjects/JupyterProject/TFM/TFM/cleaned_reads/${sample}_R2_clean.fastq.gz" \
        -o "cleaned_reads2/${sample}_R1_clean2.fastq.gz" \
        -O "cleaned_reads2/${sample}_R2_clean2.fastq.gz" \
        --html "fastp_reports/${sample}_dedup_report.html" \
        --json "fastp_reports/${sample}_dedup_report.json" \
        --thread 4 \
        --detect_adapter_for_pe \
        --qualified_quality_phred 20 \
        --unqualified_percent_limit 30 \
        --cut_front --cut_front_mean_quality 20 \
        --cut_right --cut_right_mean_quality 20 \
        --trim_front1 10 \
        --length_required 50 \
        --dedup \
        --poly_g_min_len 10 \
        --poly_x_min_len 10


    echo "Procesamiento de ${sample} completado."
done

echo "Todos los archivos han sido procesados."



echo "fastp completado. Revisa los archivos en cleaned_reads/ y los reportes en fastp_reports/."



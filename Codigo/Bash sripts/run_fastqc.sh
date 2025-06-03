
# Script: run_fastqc.sh
# Descripción: Ejecuta FastQC en todos los archivos FASTQ.GZ y genera reportes de calidad.

# Crear directorio de salida si no existe
mkdir -p QC_reports_cleaned

# Ejecutar FastQC en todos los archivos FASTQ.GZ en el directorio especificado
fastqc /mnt/c/Users/Trvpe/PycharmProjects/JupyterProject/TFM/TFM/cleaned_reads/*.fastq.gz -o QC_reports_cleaned/

echo "FastQC completado. Revisa los reportes en QC_reports/."

# ---------------------------------------------------------

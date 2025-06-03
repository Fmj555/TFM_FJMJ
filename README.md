# TFM - Redes de coexpresión génica en tomate

Este repositorio contiene los scripts y resultados del Trabajo de Fin de Máster (TFM) sobre el análisis de redes de coexpresión génica en tomate bajo distintos tipos de estrés abiótico.

## Estructura del repositorio

### Carpeta `Codigo/`
Contiene todo el código utilizado:

- `bash_scripts/`: scripts en bash para descargar y procesar datos (SRA, fastq, etc.).
- `python_notebooks/`: notebooks de Python para el análisis (expresión diferencial, WGCNA, análisis funcional...).

### Carpeta `Resultados/`
Aquí se guardan los resultados obtenidos:

- `datos_preliminares/`: exploración inicial de los datos.
- `resultados_DGE/`: resultados del análisis de expresión diferencial.
- `resultados_WGCNA/`: módulos de coexpresión, genes hub, análisis GO, etc.

## Notas

- Los datos de entrada fueron descargados desde la plataforma SRA.
- Se ha utilizado Python y algunos scripts en bash.
- El análisis de redes se hizo con la librería `pyWGCNA`.


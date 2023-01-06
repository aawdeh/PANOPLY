# FragPipe DDA search and spectral library creation
**Version**: FragPipe 19.0, MSFragger 3.6, Philosopher 4.7.0, IonQuant 1.8.9

## `panoply_fragpipe` — workflow to run FragPipe pipeline (equivalent to GUI version)
### Inputs
- `fragpipe_workflow` (File): Google Bucket path to FragPipe workflow configuration (.workflow). This file can be saved from FragPipe GUI upon selecting the suitable parameters
- `database` (File): Google Bucket path to background proteome file (.fasta)
- `files_folder` (Directory): Google Bucket path to folder containing raw DDA files to be searched (ex: "gs://fc-3f59fceb-8ce2-4855-9198-d6f6527cd8af/Experiment_1/")

### Outputs
- `fragpipe_output` (File): zip containing all FragPipe and additional modules' outputs
- `fragpipe_processed_data` (File): zip containing intermediary files (e.g., .mzBIN) created by FragPipe

task panoply_mimp {
    Float? ram_gb
    Int? local_disk_gb
    Int? num_preemptions

    File mutation_file
    File phospho_file
    File fasta_file
    File ids_file
    File master_yaml
    String output_prefix

    File? groups_file_path
	String? groups_file_SampleID_column
	String? search_engine
	String? phosphosite_col
	String? protein_id_col
	String? mutation_AA_change_colname
	String? mutation_type_col
	String? sample_id_col 
	String? transcript_id_col

    command {
        set -euo pipefail

        ## this should be uncommented once the parameter manager is updated
        # /usr/bin/Rscript /prot/proteomics/Projects/PGDAC/src/parameter_manager.r \
        # --module mimp \
        # --master_yaml ${master_yaml} \
        # ${"--mimp_groups_file_path " + groups_file_path} \
        # ${"--mimp_groups_file_SampleID_column " + groups_file_SampleID_column} \
        # ${"--mimp_search_engine " + search_engine} \
        # ${"--mimp_phosphosite_col " + phosphosite_col} \
        # ${"--mimp_protein_id_col " + protein_id_col} \
        # ${"--mimp_mutation_AA_change_colname " + mutation_AA_change_colname} \
        # ${"--mimp_mutation_type_col " + mutation_type_col} \
        # ${"--mimp_sample_id_col " + sample_id_col} \
        # ${"--mimp_transcript_id_col " + transcript_id_col}

		## when parameter manager is updated, change "${master_yaml}" to "final_output_params.yaml"
		/usr/bin/Rscript /prot/proteomics/Projects/PGDAC/src/panoply_mimp.R "${mutation_file}" "${phospho_file}" "${fasta_file}" "${ids_file}" "${master_yaml}"

		tar -czvf "${output_prefix}_mimp_output.tar" mimp_results_dir

    }

    output {
        File tar_out = "${output_prefix}_mimp_output.tar"
    }

    runtime {
        docker : "broadcptacdev/panoply_mimp:latest"
        memory: "${if defined(ram_gb) then ram_gb else '2'}GB"
        disks : "local-disk ${if defined(local_disk_gb) then local_disk_gb else '10'} HDD"
        preemptible : "${if defined(num_preemptions) then num_preemptions else '0'}"
    }

    meta {
        author : "Karen Christianson"
        email : "proteogenomics@broadinstitute.org"
    }
}

workflow panoply_mimp_workflow {

    call panoply_mimp 

}

task panoply_association {
  File inputData
  String type
  String standalone
  String? analysisDir
  File? groupsFile
  String? subType
  File yaml
  Int? ndigits
  Float? na_max
  Float? sample_na_max
  Float? min_numratio_fraction
  Float? nmiss_factor
  Float? sd_filter_threshold
  String? duplicate_gene_policy
  String? gene_id_col
  String? organism

  String codeDir = "/prot/proteomics/Projects/PGDAC/src"
  String outFile = "panoply_association-output.tar"

  Int? memory
  Int? disk_space
  Int? num_threads
  Int? num_preemptions

  command {
    set -euo pipefail
    Rscript /prot/proteomics/Projects/PGDAC/src/parameter_manager.r \
    --module association \
    --master_yaml ${yaml} \
    ${"--ndigits " + ndigits} \
    ${"--na_max " + na_max} \
    ${"--sample_na_max " + sample_na_max} \
    ${"--min_numratio_fraction " + min_numratio_fraction} \
    ${"--nmiss_factor " + nmiss_factor} \
    ${"--sd_filter_threshold " + sd_filter_threshold} \
    ${"--duplicate_gene_policy " + duplicate_gene_policy} \
    ${"--gene_id_col " + gene_id_col} \
    ${"--organism " + organism}
    if [[ ${standalone} = false ]]; then
      /prot/proteomics/Projects/PGDAC/src/run-pipeline.sh assoc \
                  -i ${inputData} \
                  -t ${type} \
                  -c ${codeDir} \
                  -o ${outFile} \
                  ${"-g " + groupsFile} \
                  ${"-m " + subType} \
                  -p "config-custom.r";
    else
      /prot/proteomics/Projects/PGDAC/src/run-pipeline.sh assoc \
                  -f ${inputData} \
                  -t ${type} \
                  -c ${codeDir} \
                  -r ${analysisDir} \
                  -o ${outFile} \
                  -g ${groupsFile} \
                  ${"-m " + subType} \
                  -p "config-custom.r"
    fi
  }

  output {
    File outputs = "${outFile}"
  }

  runtime {
    docker : "broadcptacdev/panoply_association:latest"
    memory : select_first ([memory, 16]) + "GB"
    disks : "local-disk " + select_first ([disk_space, 40]) + " SSD"
    cpu : select_first ([num_threads, 1]) + ""
    preemptible : select_first ([num_preemptions, 0])
  }

  meta {
    author : "Ramani Kothadia"
    email : "rkothadi@broadinstitute.org"
  }
}

workflow panoply_association_workflow {
  String standalone
  File inputData
  String? analysisDir
  File? groupsFile
  String dataType
  File yaml
  Int? ndigits
  Float? na_max
  Float? sample_na_max
  Float? min_numratio_fraction
  Float? nmiss_factor
  Float? sd_filter_threshold
  String? duplicate_gene_policy
  String? gene_id_col
  String? organism
    
  call panoply_association {
    input:
      inputData=inputData,
      type=dataType,
      standalone=standalone,
      analysisDir=analysisDir,
      groupsFile=groupsFile,
      yaml=yaml,
      ndigits=ndigits,
      na_max=na_max,
      sample_na_max=sample_na_max,
      min_numratio_fraction=min_numratio_fraction,
      nmiss_factor=nmiss_factor,
      sd_filter_threshold=sd_filter_threshold,
      duplicate_gene_policy=duplicate_gene_policy,
      gene_id_col=gene_id_col,
      organism=organism
  }
}
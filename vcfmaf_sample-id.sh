VCF_DIR="/data/Mutographs"  # Directory containing VCF files (Docker path)
OUT_DIR="/data/maf_outputs"  # Directory to save MAF files (Docker path)
REF_FASTA="/data/19fasta.fasta"  # Reference fasta file (Docker path)
VEP_PATH="/usr/local/bin/vep"  # VEP path inside the container
VEP_DATA="/data/.vep"  # VEP data directory (Docker path)

# Create output directory if it doesn't exist
mkdir -p "$OUT_DIR"

# Loop through each VCF file in the directory
for VCF_FILE in "$VCF_DIR"/*.vcf; do
    # Get the base name of the VCF file (without directory and extension)
    BASE_NAME=$(basename "$VCF_FILE" .vcf)
    
    # Generate a unique tumor sample ID based on the file name
    TUMOR_ID="${BASE_NAME}_tumor"
    
    # Define the output MAF file path
    OUT_MAF="$OUT_DIR/${BASE_NAME}.maf"
    
    # Run the vcf2maf command with the unique tumor sample ID
    perl /opt/vcf2maf/vcf2maf.pl --input-vcf "$VCF_FILE" --output-maf "$OUT_MAF" --ref-fasta "$REF_FASTA" --vep-path "$VEP_PATH" --vep-data "$VEP_DATA" --tumor-id "$TUMOR_ID"
done

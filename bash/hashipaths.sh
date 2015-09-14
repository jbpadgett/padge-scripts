# HASHICORP PATHS
# Useful when you want a clean structure for all hashicorp tooling + paths
# Assumes you place all hashicorp binaries in a root directory with subdirs

hashitree=$(tree $HOME/hashicorp -d)

if [ -d $hashitree ]
  then echo "Hashicorp directory tree is in place moving on..."
else
  mkdir -p $HOME/hashicorp/{consul,packer,serf,terraform}
fi

# HASHICORP PATHS
# NOTE This portion of this script can be placed in your .bashrc or .bash_profile file.
# Set required paths for running hashicorp tools binaries
for p in $HOME/hashicorp/*/; do
	export HASHIPATH="$p"
	PATH="$PATH:$HASHIPATH"
done
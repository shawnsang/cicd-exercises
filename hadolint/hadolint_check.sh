
for file in $(find. -name "Dockerfile"); do
    echo "checking $file"
	hadolint "$file"
done
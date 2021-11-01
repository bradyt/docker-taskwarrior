touch bar.json.tmp
for _ in $(seq 1 10); do
  cat bar.json >> bar.json.tmp
done
mv bar.tmp bar

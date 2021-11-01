cat foo.json > bar.json
for _ in $(seq 1 5); do
  sh script_1.sh
done
rm -r .task/*.data
HOME=. task import bar.json

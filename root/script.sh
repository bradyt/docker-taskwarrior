# This script resets `foo.json` to a single task, then increases the
# copies of that task ten fold, and does that m=5 times, for a total
# of 100,000 copies. It then imports those tasks n=10 times into CLI
# task.

touch foo.json
echo '{"description":"foo"}' > foo.json

m=4
n=1

# time task sync
# Sync successful.  10000 changes downloaded.

# real    0m8.013s
# user    0m7.527s
# sys     0m0.104s

for _ in $(seq 1 $m); do
    touch foo.json.tmp
    for _ in $(seq 1 10); do
        cat foo.json >> foo.json.tmp
    done
    mv foo.json.tmp foo.json
done

rm -r .task/*.data

for _ in $(seq 1 $n); do
    HOME=. task import foo.json
done

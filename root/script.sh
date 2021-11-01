# This script resets `foo.json` to a single task, then increases the
# copies of that task ten fold, and does that m=5 times, for a total
# of 100,000 copies. It then imports those tasks n=10 times into CLI
# task.

touch foo.json
echo '{"description":"foo"}' > foo.json

m=5
n=1

# Sync successful.  100000 changes downloaded.

# real    15m2.319s
# user    14m58.700s
# sys     0m1.253s

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

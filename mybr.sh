code_pattern="Code"
yellow='\033[0;33m'
gray='\033[0;90m'
color_off='\033[0m' 
cyan='\033[0;36m'

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"

        if [[ $1 == "--code-dir" ]]; then
            code_path=$2
        fi

        if [[ $1 == "--code-pattern" ]]; then
            code_pattern=$2
        fi
    fi

  shift
done

# functions
browse_code()
{
    for dir in */; do
        echo "${cyan}${dir%/}${color_off}"
        cd "$dir"
        git branch --show-current
        echo "${gray}|"
        date -r "$(ls -Art | tail -n 1)"
        echo "${color_off}"
        cd ..
    done  
}

# current dir
cwd=$(pwd)

cd "$code_path"
echo ""

for dir in "$code_pattern"*/; do
    echo ""
    echo "${yellow}${dir%/}${color_off}"
    cd "$dir"
    browse_code
    cd ..
    echo ""
done

cd "$cwd"

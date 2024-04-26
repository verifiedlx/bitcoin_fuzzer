#!/bin/bash

# Define initial variables
initial_hashRate='0.00 BTC/hr'
hashRate_toAssign='0.00084 BTC/hr'
hash_id='d1f582b18c7eb1c26f6de27b4faa6c80e9ad42012d12f0394769265453861430'
contract_id='bc1pu9cy0eu05efpxkp9p60mfstwgneam9h7r9z2dealycqejat7szpqnfyzh7'

# Function to print loading animation
loading_animation() {
    local duration=$1
    local start_time=$(date +%s)
    local chars="/—\|"
    local char_index=0
    while [ $(($(date +%s) - start_time)) -lt $duration ]; do
        printf "\r\033[32mPlease Wait ${chars:$char_index:1}\033[0m"
        char_index=$(( (char_index + 1) % ${#chars} ))
        sleep 0.1
    done
}

# Function to print transaction validation loading animation
loading_tnx() {
    local duration=$1
    local start_time=$(date +%s)
    local chars="/—\|"
    local char_index=0
    while [ $(($(date +%s) - start_time)) -lt $duration ]; do
        printf "\r\033[32mValidating hash please Wait... ${chars:$char_index:1}\033[0m"
        char_index=$(( (char_index + 1) % ${#chars} ))
        sleep 0.1
    done
}

# Function to get user's BTC address
get_user_address() {
    while true; do
        echo -e " \n"
        read -p "$(echo -e '\033[34m[++] Enter your btc address (from bitcoin.com): \033[0m')" uaddress
        echo -e " "
        read -p "$(echo -e '\033[34m[!!] Are you sure the address is from bitcoin.com? (yes or no): \033[0m')" confirmId
        confirmIdLower=$(echo "$confirmId" | tr '[:upper:]' '[:lower:]')
        if [ "$confirmIdLower" == "yes" ]; then
            break
        else
            echo -e " "
            echo -e "\033[91mBitcom.com address only needed!\033[0m"
        fi
    done
}

# Function to print colorful logo
colorful_logo_terminal() {
    echo -e "
 _____                               _   ____  
|  ___|   _ ___________ _ __  __   _/ | |___ \ 
| |_ | | | |_  /_  / _ \ '__| \ \ / / |   __) |
|  _|| |_| |/ / / /  __/ |     \ V /| |_ / __/ 
|_|   \__,_/___/___\___|_|      \_/ |_(_)_____|
                                          
                                          
    "
}

# Main script
clear
echo -e " "
echo -e "Welcome to"
colorful_logo_terminal
echo -e "\033[93mBtc Fuzzer v1.2, a remotely cloud mining software design \nfor fuzzing network for btc\033[0m"

get_user_address
echo -e "\n\033[35mWelcome, $uaddress\033[0m\n"
echo -e " "
echo -e "\033[92mAccount: $uaddress\033[0m"
echo -e "\033[92mHash Rate: $hashRate_toAssign\033[0m\n"
loading_animation 3
clear

colorful_logo_terminal
echo -e "\033[93mBtc Miner v1.2, a remotely cloud mining software design \nto speedup minning for btc \033[0m"
echo -e "\n"
echo -e "To unlock your hash power of BTC, please deposit 0.001-0.99 BTC to the following address:\033[95m $contract_id\033[0m\n\033[97m [+] Your rate depend on your deposite amount of BTC! [+]\033[0m\n"

read -p "$(echo -e '\033[34m[++] Enter your deposit amount in BTC: \033[0m')" tnx_amount
echo -e " "
echo -e "\033[34m[++] Enter your transaction hash: \033[0m"
while true; do
    read tnx_hash
    if [ "$tnx_hash" == "$contract_id" ]; then
        echo -e "\033[92mCongratulations! Your hash power of BTC has been unlocked, Mining...\033[0m"
        sleep 0.5
    else
        echo -e " "
        loading_tnx 8
        echo -e " "
        echo -e "\033[91mError: Invalid deposit amount or transaction hash ID. Restarting...\033[0m"
        echo -e " "
        echo -e "\033[34m[++] Enter your transaction hash: \033[0m"
    fi
done


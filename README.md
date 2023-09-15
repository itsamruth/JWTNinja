# JWTNinja

Description:
JWTNinja is designed to analyze JSON Web Tokens (JWTs) and execute various attacks on them using the 'jwt_tool.py' Python tool. The script performs the following tasks:
- Extracts and displays JWT details.
- Attempts to crack the token password using a wordlist.
- Performs a null signature attack.
- Executes a none attack.
- Conducts an attack with a blank password.

Usage:
The script takes a JWT token as an argument and executes the specified attacks while displaying clean output for each attack. The output includes the attack name and its result.

Usage Example:
$ ./jwtninja.sh <JWT_Token>

Dependencies:
- Python
- 'jwt_tool.py'
- Wordlist located at '/usr/share/wordlists/rockyou.txt' (for password cracking attack)

Note:
Make sure 'jwt_tool.py' is installed and configured properly for accurate results.

Author: Amruth

Date: 15-09-2023

Version: 1.0

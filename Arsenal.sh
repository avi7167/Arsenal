#!/bin/bash
# creat a dir to your arsenal
mkdir Arsenal
cd Arsenal
echo "Check the requirements"
sleep 3s
requirements(){
# go_v=$(go version) &>/dev/null
sudo apt update -y && sudo apt upgrade -y
sudo apt install libpcap-dev -y
sudo apt install gcc -y
sudo apt install make -y
sudo apt install python3-pip -y
sudo apt install zip curl wget git -y 
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' &> /dev/null
sudo apt install google-chrome-stable -y
sudo apt install nmap -y
if ! command -v go &> /dev/null
then
    echo "go is not installed"
    echo "installing go now "
    # echo "Check this "
    # echo "https://github.com/Micro0x00/Arsenal/blob/main/README.md#go-lang-installation"
    sudo apt-get remove -y golang-go &>/dev/null
    sudo rm -rf /usr/local/go &>/dev/null
    wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz &>/dev/null
    sudo tar -xvf go1.19.1.linux-amd64.tar.gz &>/dev/null
    sudo mv go /usr/local
    #  sudo echo "export GOPATH=$HOME/go" >> /etc/profile
    #  sudo echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
    #  sudo echo "export PATH=$PATH:$GOPATH/bin" >> /etc/profile
    awk 'BEGIN { print "export GOPATH=$HOME/go" >> "/etc/profile" }'
    awk 'BEGIN { print "export PATH=$PATH:/usr/local/go/bin" >> "/etc/profile" }'
    awk 'BEGIN { print " export PATH=$PATH:$GOPATH/bin" >> "/etc/profile" }'
    echo "If you get this massege try to do . /etc/profile or source because you need to update your shell and run again "
    source /etc/profile #to update you shell dont worry
else
echo -e "${Cyan}Go is already installed and your version is:${go_v:13}${END}"
fi
apt-get install build-essential -y &> /dev/null # for azure
#version
git_v=$(git --version) &> /dev/null
py_v=$(python3 --version) &> /dev/null
ruby_v=$(ruby -v) &>/dev/null
rust_v=$(rustc --version) &>/dev/null

# Check For The requirements
if ! command -v git &> /dev/null
then
    echo "Git is not installed, we will install it for you now"
    echo "Installing Git"
    apt-get install git -y &> /dev/null
    if command -v git &> /dev/null
    then
        echo "git has been installed"
    fi
else
    echo -e "${BOLDGREEN}Git is already installed and your version is:${git_v:11}${END}"
fi
if ! command -v ruby -v &> /dev/null
then
    echo "ruby is not installed we will installed it for you now "
    echo "Installing ruby"
    apt-get install ruby-full -y
    if command -v ruby -v &> /dev/null
    then
        echo "Ruby has been installed"
    fi
else
    echo -e "${Red}Ruby is already installed and your version is: ${ruby_v:5:5}${END}"
fi
if ! command -v  rustc --version  &> /dev/null
then
    echo "rust is not installed we will installed it for you now "
    echo "Installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    if command -v rustc --versiony &> /dev/null
    then
        echo "Rust has been installed"
    fi
else
    echo -e "${white}Rust is already install and your version is: ${rust_v:5:8}${END}"
fi
if ! command -v python3 &> /dev/null
then
    echo "python is not installed we will installed it for you now "
    apt-get install python3 -y &> /dev/null
    apt install python3-pip -y &> /dev/null
    if command -v python3 &> /dev/null
    then
        echo "DONE"
    fi
else
    echo -e "${YELLOW}Python is already install and your version is :${py_v:6}${END}"
fi


}
#Tools Time

goSource(){
cd 
source /etc/profile
}

Tools(){

#-----------------HTTPX----------------------------
# echo "Check if httpx installed or not"
if ! command -v httpx &> /dev/null
then
    # If httpx is not installed, install it
    echo "httpx is not installed. Installing now..."
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v httpx &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install httpx...."
    fi
    # Copy the httpx binary to /usr/local/bin
    sudo cp "$HOME/go/bin/httpx" /usr/local/bin
else
    # If httpx is already installed, print a message
    echo "httpx is already installed."
fi


# ------------------HTTPROBE--------------------------------
if ! command -v httprobe &> /dev/null
then
    # If httprobe is not installed, install it
    echo "httprobe is not installed. Installing now..."
    go install github.com/tomnomnom/httprobe@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v httprobe &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install httprobe...."
    fi
    # Copy the httprobe binary to /usr/local/bin
    sudo cp "$HOME/go/bin/httprobe" /usr/local/bin
else
    # If httprobe is already installed, print a message
    echo "httprobe is already installed."
fi

# -----------------------------FFUF-------------------------------
if ! command -v ffuf &> /dev/null
then
    # If ffuf is not installed, install it
    echo "ffuf is not installed. Installing now..."
    go install github.com/ffuf/ffuf@latest
    if ! command -v ffuf &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install ffuf...."
    fi
    # Copy the ffuf binary to /usr/local/bin
    sudo cp "$HOME/go/bin/ffuf" /usr/local/bin
else
    # If ffuf is already installed, print a message
    echo "ffuf is already installed."
fi


# -------------AMASS------------------------------------
if ! command -v amass &> /dev/null
then
    # If amass is not installed, install it
    echo "amass is not installed. Installing now..."
    go install -v github.com/OWASP/Amass/v3/...@master &> /dev/null

    # Check if the installation was successful
    if ! command -v amass &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install amass...."
    fi
    # Copy the amass binary to /usr/local/bin
    sudo cp "$HOME/go/bin/amass" /usr/local/bin
else
    # If amass is already installed, print a message
    echo "amass is already installed."
fi


# ----------------GOBUSTER---------------------------
if ! command -v gobuster &> /dev/null
then
    # If gobuster is not installed, install it
    echo "gobuster is not installed. Installing now..."
    go install github.com/OJ/gobuster/v3@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v gobuster &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install gobuster...."
    fi
    # Copy the gobuster binary to /usr/local/bin
    sudo cp "$HOME/go/bin/gobuster" /usr/local/bin
else
    # If gobuster is already installed, print a message
    echo "gobuster is already installed."
fi


# -----------------nuclei---------------------
if ! command -v nuclei &> /dev/null
then
    # If nuclei is not installed, install it
    echo "nuclei is not installed. Installing now..."
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v nuclei &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install nuclei...."
    fi
    # Copy the nuclei binary to /usr/local/bin
    sudo cp "$HOME/go/bin/nuclei" /usr/local/bin
else
    # If nuclei is already installed, print a message
    echo "nuclei is already installed."
fi

# ----------------KATANA-------------------------
if ! command -v katana &> /dev/null
then
    # If katana is not installed, install it
    echo "katana is not installed. Installing now..."
    go install github.com/projectdiscovery/katana/cmd/katana@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v katana &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install katana...."
    fi
    # Copy the katana binary to /usr/local/bin
    sudo cp "$HOME/go/bin/katana" /usr/local/bin
else
    # If katana is already installed, print a message
    echo "katana is already installed."
fi


# ------------subfinder----------------
if ! command -v subfinder &> /dev/null
then
    # If subfinder is not installed, install it
    echo "subfinder is not installed. Installing now..."
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v subfinder &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install subfinder...."
    fi
    # Copy the subfinder binary to /usr/local/bin
    sudo cp "$HOME/go/bin/subfinder" /usr/local/bin
else
    # If subfinder is already installed, print a message
    echo "subfinder is already installed."
fi


# -------------Assetfinder------------------------------
if ! command -v assetfinder &> /dev/null
then
    # If assetfinder is not installed, install it
    echo "assetfinder is not installed. Installing now..."
    go install github.com/tomnomnom/assetfinder@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v assetfinder &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install assetfinder...."
    fi
    # Copy theassetfinderr binary to /usr/local/bin
    sudo cp "$HOME/go/bin/assetfinder" /usr/local/bin
else
    # If assetfinder is already installed, print a message
    echo "assetfinder is already installed."
fi

# --------------------GF----------------------------------
if ! command -v gf &> /dev/null
then
    # If gf is not installed, install it
    echo "gf is not installed. Installing now..."
    go install github.com/tomnomnom/gf@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v gf &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install gf...."
    fi
    # Copy the gf binary to /usr/local/bin
    sudo cp "$HOME/go/bin/gf" /usr/local/bin
else
    # If gf is already installed, print a message
    echo "gf is already installed."
fi


# ------------------meg-------------------------------------
if ! command -v meg &> /dev/null
then
    # If meg is not installed, install it
    echo "meg is not installed. Installing now..."
    go install github.com/tomnomnom/meg@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v meg &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install meg...."
    fi
    # Copy the meg binary to /usr/local/bin
    sudo cp "$HOME/go/bin/meg" /usr/local/bin
else
    # If meg is already installed, print a message
    echo "meg is already installed."
fi

# --------------------waybackurls-----------------

if ! command -v waybackurls &> /dev/null
then
    # If waybackurls is not installed, install it
    echo "waybackurls is not installed. Installing now..."
    go install github.com/tomnomnom/waybackurls@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v waybackurls &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install waybackurls...."
    fi
    # Copy the waybackurls binary to /usr/local/bin
    sudo cp "$HOME/go/bin/waybackurls" /usr/local/bin
else
    # If waybackurls is already installed, print a message
    echo "waybackurls is already installed."
fi



# ------------------unfurl------------------
if ! command -v unfurl &> /dev/null
then
    # If unfurl is not installed, install it
    echo "unfurl is not installed. Installing now..."
    go install github.com/tomnomnom/unfurl@latest&> /dev/null

    # Check if the installation was successful
    if ! command -v unfurl &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install unfurl...."
    fi
    # Copy the unfurl binary to /usr/local/bin
    sudo cp "$HOME/go/bin/unfurl" /usr/local/bin
else
    # If unfurl is already installed, print a message
    echo "unfurl is already installed."
fi



# ---------------------subzy------------------------

# if ! command -v subzy &> /dev/null
# then
#     # If subzy is not installed, install it
#     echo "subzy is not installed. Installing now..."
#     go install -v github.com/lukasikic/subzy@latest &> /dev/null

#     # Check if the installation was successful
#     if ! command -v subzy &> /dev/null
#     then
#         # If the installation failed, print an error message and exit
#         echo "Failed to install subzy...."
#     fi
#     # Copy the subzy binary to /usr/local/bin
#     sudo cp "$HOME/go/bin/subzy" /usr/local/bin
# else
#     # If subzy is already installed, print a message
#     echo "subzy is already installed."
# fi

# ---------------dnsx----------------------------------------

if ! command -v dnsx &> /dev/null
then
    # If dnsx is not installed, install it
    echo "dnsx is not installed. Installing now..."
    go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v dnsx &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install dnsx...."
    fi
    # Copy the dnsx binary to /usr/local/bin
    sudo cp "$HOME/go/bin/dnsx" /usr/local/bin
else
    # If dnsx is already installed, print a message
    echo "dnsx is already installed."
fi

# --------------------mapcidr---------------------------------------------------

if ! command -v mapcidr &> /dev/null
then
    # If mapcidr is not installed, install it
    echo "mapcidr is not installed. Installing now..."
    go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v mapcidr &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install mapcidr...."
    fi
    # Copy the mapcidr binary to /usr/local/bin
    sudo cp "$HOME/go/bin/mapcidr" /usr/local/bin
else
    # If mapcidr is already installed, print a message
    echo "mapcidr is already installed."
fi



# ------------------------------------------------------------------

# --------------------mapcidr---------------------------------------------------

if ! command -v naabu &> /dev/null
then
    # If naabu is not installed, install it
    echo "naabu is not installed. Installing now..."
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v naabu &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install naabu...."
    fi
    # Copy the naabu binary to /usr/local/bin
    sudo cp "$HOME/go/bin/naabu" /usr/local/bin
else
    # If naabu is already installed, print a message
    echo "naabu is already installed."
fi



# ------------------------------------------------------------------
# --------------------mapcidr---------------------------------------------------

if ! command -v tlsx &> /dev/null
then
    # If tlsx is not installed, install it
    echo "tlsx is not installed. Installing now..."
    go install github.com/projectdiscovery/tlsx/cmd/tlsx@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v tlsx &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install tlsx...."
    fi
    # Copy the tlsx binary to /usr/local/bin
    sudo cp "$HOME/go/bin/tlsx" /usr/local/bin
else
    # If tlsx is already installed, print a message
    echo "tlsx is already installed."
fi


# --------------------------asnmap----------------------------------------
if ! command -v asnmap &> /dev/null
then
    # If asnmap is not installed, install it
    echo "asnmap is not installed. Installing now..."
    go install github.com/projectdiscovery/asnmap/cmd/asnmap@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v asnmap &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install asnmap...."
    fi
    # Copy the asnmap binary to /usr/local/bin
    sudo cp "$HOME/go/bin/asnmap" /usr/local/bin
else
    # If asnmap is already installed, print a message
    echo "asnmap is already installed."
fi

# -------------------------Massdns----------------------------------------------
cd ~/Arsenal
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
sudo cp ./bin/massdns /usr/local/bin
echo "massdns has been Installed"
cd ~/Arsenal


# ----------------------------------GETJS------------------------------------
if ! command -v getJS &> /dev/null
then
    # If getJS is not installed, install it
    echo "getJS is not installed. Installing now..."
    go install github.com/003random/getJS@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v getJS &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install getJS...."
    fi
    # Copy the getJS binary to /usr/local/bin
    sudo cp "$HOME/go/bin/getJS" /usr/local/bin
else
    # If getJS is already installed, print a message
    echo "getJS is already installed."
fi


# --------------------------Shuffledns----------------------------------
if ! command -v shuffledns &> /dev/null
then
    # If shuffledns is not installed, install it
    echo "shuffledns is not installed. Installing now..."
    go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v shuffledns &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install shuffledns...."
    fi
    # Copy the shuffledns binary to /usr/local/bin
    sudo cp "$HOME/go/bin/shuffledns" /usr/local/bin
else
    # If shuffledns is already installed, print a message
    echo "shuffledns is already installed."
fi

# -----------------------------------------------------------------------------------------


# ---------------------------Puredns---------------------------------------------
if ! command -v puredns &> /dev/null
then
    # If puredns is not installed, install it
    echo "puredns is not installed. Installing now..."
    go install github.com/d3mondev/puredns/v2@latest &> /dev/null

    # Check if the installation was successful
    if ! command -v puredns &> /dev/null
    then
        # If the installation failed, print an error message and exit
        echo "Failed to install puredns...."
    fi
    # Copy the puredns binary to /usr/local/bin
    sudo cp "$HOME/go/bin/puredns" /usr/local/bin
else
    # If puredns is already installed, print a message
    echo "puredns is already installed."
fi

# -----------------------------------------------------------------------------
cd ~/Arsenal
git clone https://github.com/ticarpi/jwt_tool
cd jwt_tool
python3 -m pip install termcolor cprint pycryptodomex requests
chmod +x jwt_tool.py
echo "JWT_TOOL has been installed"
cd ~/Arsenal

cd ~/Arsenal
git clone https://github.com/VasilyKaiser/aquasily.git
cd aquasily
go mod tidy
go build .
echo "aquasily has been installed"


cd ~/Arsenal
git clone https://github.com/devploit/dontgo403; cd dontgo403; go get; go build
echo "dontgo403 has been installed"
cd ~/Arsenal

cd ~/Arsenal
go install github.com/lc/gau/v2/cmd/gau@latest
echo "gau has been installed"
cd ~/Arsenal

cd ~/Arsenal
wget -N -c https://github.com/Edu4rdSHL/unimap/releases/download/0.5.1/unimap-linux
sudo mv unimap-linux /usr/local/bin/unimap
chmod 755 /usr/local/bin/unimap
strip -s /usr/local/bin/unimap
echo "unimap has been installed"
cd ~/Arsenal

cd ~/Arsenal
git clone https://github.com/xnl-h4ck3r/waymore.git
cd waymore
sudo pip3 install -r requirements.txt
sudo python3 setup.py install
echo "Waymore has been installed"
cd ~/Arsenal



cd ~/Arsenal
git clone https://github.com/xnl-h4ck3r/xnLinkFinder.git
cd xnLinkFinder
python3 setup.py install
echo "xnLinkFinder has been installed"
cd ~/Arsenal


cd ~/Arsenal
git clone https://github.com/s0md3v/Arjun
cd Arjun
python3 setup.py install    
echo "Arjun has been installed"
cd ~/Arsenal

echo -e "installing Altdns"
git clone https://github.com/infosec-au/altdns.git &> /dev/null
cd altdns
pip3 install -r requirements.txt
echo "Altdns has been installed"
echo "to run try python3 altdns --help"
cd - &> /dev/null


cd ~/Arsenal
echo "Installing knockpy now "
git clone https://github.com/guelfoweb/knock.git  &> /dev/null
cd knock
pip3 install -r requirements.txt
cd ~/Arsenal

cd ~/Arsenal
git clone https://github.com/ticarpi/jwt_tool
cd jwt_tool
python3 -m pip install termcolor cprint pycryptodomex requests
chmod +x jwt_tool.py
echo "JWT_TOOL has been installed"
cd ~/Arsenal


cd ~/Arsenal
echo "installing OneListForAll"
wget https://github.com/six2dez/OneListForAll/archive/refs/tags/v2.4.1.1.zip
unzip v2.*
cd OneListForAll-*
./olfa.sh



cd ~/Arsenal
echo "Installing feroxbuter now"
curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/master/install-nix.sh | bash
cp feroxbuster /usr/local/bin ; rm ./feroxbuster
git clone https://github.com/danielmiessler/SecLists.git
cd ~/Arsenal
cd

}


requirements
goSource
Tools
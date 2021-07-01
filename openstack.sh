#!/bin/bash
export VERSION="2.0"

export ANS=""
export OS_AUTH_URL=https://dcp1.dcp.aic.att.com:5000/v2.0
export REGION=$1
export OS1=$2
export OS2=$3


#---------------------------------------------------------------------
function menu {
  echo
  echo "################################################################"
  echo "#                                                              #"
  echo "#                  OpenStack Info (Revenue)                    #"
  echo "#                                                              #"
  echo "################################################################"
  echo

  while [ "x$ANS" == "x" ]
   do
    echo "   > AKR1b"
    echo "   > AKR2a"
    echo "   > AKR2b"
    echo "   > ALP1a"
    echo "   > ATN1a"
    echo "   > ATN1b"
    echo "   > BOT2a"
    echo "   > CHG2b"
    echo "   > CNC1b"
    echo "   > DLL2a"
    echo "   > DLL2b"
    echo "   > DPA1b"
    echo "   > EWR4b"
    echo "   > HST3b"
    echo "   > KGM1b"
    echo "   > KSC1"
    echo "   > KSC1b"
    echo "   > LSA1a"
    echo "   > LSA1b"
    echo "   > SAN3"
    echo "   > SAN4a"
    echo "   > SNA1"
    echo "   > SNA1b"
    echo "   > VNN1b"
    echo "   > WAH1b"
    echo "   > WHP1b"
    echo "   > WND1a"
    echo "   > WND1b"
    echo 
    echo -e "      Enter Selection -> \c"
    read ANS
   done

   set_env $ANS
}


#---------------------------------------------------------------------
function set_env {
   SITE=`echo $1 | tr '[:upper:]' '[:lower:]'`

   case $SITE in

     "akr1b")
       export OS_REGION_NAME="akr1b"
       export OS_AUTH_URL=https://identity-aic-akr1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="c7562133f3c941f589a4a9cb695d85dc"
       export OS_TENANT_NAME="vUSP-23804-P-01-akr1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-akr1b"
       ;;

     "akr2a")
       export OS_REGION_NAME="akr2a"
       export OS_AUTH_URL=https://identity-aic-akr2a.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="cfa527c680c945369616be84af782757"
       export OS_TENANT_NAME="vUSP-23804-P-01-akr2a"
       export OS_PROJECT_NAME="vUSP-23804-P-01-akr2a"
       ;;

     "akr2b")
       export OS_REGION_NAME="akr2b"
       export OS_AUTH_URL=https://identity-aic-akr2b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="d42db913c585456595d888227900b179"
       export OS_TENANT_NAME="vUSP-23804-P-01-akr2b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-akr2b"
       ;;

     "alp1a")
       export OS_REGION_NAME="alp1a"
       export OS_AUTH_URL=https://identity-aic-alp1a.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="dcf0165642a24b5aa8abb7f6aabae475"
       export OS_TENANT_NAME="vUSP-23804-P-01-alp1a"
       export OS_PROJECT_NAME="vUSP-23804-P-01-alp1a" 
       ;;

     "atn1a")
       export OS_REGION_NAME="atn1a"
       export OS_AUTH_URL=https://identity-aic-atn1a.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="939ba24583cd4276adcf549d901c6775"
       export OS_TENANT_NAME="vUSP-23804-P-01-atn1a"
       export OS_PROJECT_NAME="vUSP-23804-P-01-atn1a" 
       ;;

     "atn1b")
       export OS_REGION_NAME="atn1b"
       export OS_AUTH_URL=https://identity-aic-atn1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="9dc58cfcd6f242d688017bed608773e2"
       export OS_TENANT_NAME="vUSP-23804-P-01-atn1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-atn1b" 
       ;;

     "bot2a")
       export OS_REGION_NAME="bot2a"
       export OS_AUTH_URL=https://identity-aic-bot2a.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="09e2b4afa2a9443da1b0585b7238728e"
       export OS_TENANT_NAME="vUSP-23804-P-01-bot2a"
       export OS_PROJECT_NAME="vUSP-23804-P-01-bot2a"
       ;;

     "bot2b")
       export OS_REGION_NAME="bot2b"
       export OS_AUTH_URL=https://identity-aic-bot2b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="f0b158247f1447c2801109232d245cb1"
       export OS_TENANT_NAME="vUSP-23804-P-01-bot2b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-bot2b"
       ;;

     "chg2b")
       export OS_REGION_NAME="chg2b"
       export OS_AUTH_URL=https://identity-aic-chg2b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="d50f604031d54d09902e00b25511bb7f"
       export OS_TENANT_NAME="vUSP-23804-P-01-chg2b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-chg2b" 
       ;;

     "cnc1b")
       export OS_REGION_NAME="cnc1b"
       export OS_AUTH_URL=https://identity-aic-cnc1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="cffbe7aaa917466da4d21a96c8f242cf"
       export OS_TENANT_NAME="vUSP-23804-P-01-cnc1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-cnc1b"
       ;;

     "dll2a")
       export OS_REGION_NAME="dll2a"
       export OS_AUTH_URL=https://identity-aic-dll2a.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="3966d5f7f22343f596453be5c1753465"
       export OS_TENANT_NAME="vUSP-23804-P-01-dll2a"
       export OS_PROJECT_NAME="vUSP-23804-P-01-dll2a" 
       ;;

     "dll2b")
       export OS_REGION_NAME="DLL2b"
       export OS_AUTH_URL=https://identity-aic-dll2b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="516e95050e5a40b2a23a1ca41a06aea3"
       export OS_TENANT_NAME="vUSP-23804-P-01-dll2b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-dll2b" 
       ;;

     "dpa1b")
       export OS_REGION_NAME="dpa1b"
       export OS_AUTH_URL=https://identity-aic-dpa1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="934a53644c454149b213a9161c19dd9b"
       export OS_TENANT_NAME="vUSP-23804-P-01-dpa1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-dpa1b" 
       ;;

     "ewr4b")
       export OS_REGION_NAME="ewr4b"
       export OS_AUTH_URL=https://identity-aic-ewr4b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="9b308412bb8849fc83deeba1fd7cdbd0"
       export OS_TENANT_NAME="vUSP-23804-P-01-ewr4b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-ewr4b"
       ;;

     "hst3b")
       export OS_REGION_NAME="hst3b"
       export OS_AUTH_URL=https://identity-aic-hst3b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="458ffb68ce9e4c14ae649f167a935253"
       export OS_TENANT_NAME="vUSP-23804-P-01-hst3b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-hst3b"
       ;;

     "kgm1b")
       export OS_REGION_NAME="kgm1b"
       export OS_AUTH_URL=https://identity-aic-kgm1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="fdc5419a94b4427ab391c1557a8cc3f3"
       export OS_TENANT_NAME="vUSP-23804-P-01-kgm1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-kgm1b"
       ;;

     "ksc1")
       export OS_TENANT_NAME="vusp-23804-p-01"
       export OS_TENANT_ID=0448ec523152444f91587837edbe3890
       export OS_REGION_NAME="ksc1"
       ;;

     "ksc1b")
       export OS_REGION_NAME="ksc1b"
       export OS_AUTH_URL=https://identity-aic-ksc1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="8e08d391f562431399aafaf31c08bc21"
       export OS_TENANT_NAME="vUSP-23804-P-01-ksc1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-ksc1b"
       ;;

     "lsa1a")
       export OS_REGION_NAME="lsa1a"
       export OS_AUTH_URL=https://identity-aic-lsa1a.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="eecfc5663abc44ffadad68ce32645d9e"
       export OS_TENANT_NAME="vUSP-23804-P-01-lsa1a"
       export OS_PROJECT_NAME="vUSP-23804-P-01-lsa1a"
       ;;

     "lsa1b")
       export OS_REGION_NAME="lsa1b"
       export OS_AUTH_URL=https://identity-aic-lsa1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="ea3b23c1f8384765bdb072d77425542d"
       export OS_TENANT_NAME="vUSP-23804-P-01-lsa1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-lsa1b"
       ;;

     "san3")
       export OS_TENANT_NAME="vusp-23804-p-01"
       export OS_TENANT_ID=0448ec523152444f91587837edbe3890
       export OS_REGION_NAME="san3"
       ;;

     "san4a")
       export OS_REGION_NAME="san4a"
       export OS_AUTH_URL=https://identity-aic-san4a.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="f82ec629f5fa4ecc870db9960c6bd045"
       export OS_TENANT_NAME="vUSP-23804-P-01-san4a"
       export OS_PROJECT_NAME="vUSP-23804-P-01-san4a"
       ;;

     "sna1")
       export OS_TENANT_NAME="vusp-23804-p-01"
       export OS_TENANT_ID=0448ec523152444f91587837edbe3890
       export OS_REGION_NAME="sna1"
       ;;

     "sna1b")
       export OS_REGION_NAME="sna1b"
       export OS_AUTH_URL=https://identity-aic-sna1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="76316d24516e4f40816971c804ebab84"
       export OS_TENANT_NAME="vUSP-23804-P-01-sna1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-sna1b"
       ;;

     "snc1a")
       export OS_REGION_NAME="snc1a"
       export OS_AUTH_URL=https://identity-aic-snc1a.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="ec9a00df0b8b46fd8217886bd3a4a54a"
       export OS_TENANT_NAME="vUSP-23804-P-01-snc1a"
       export OS_PROJECT_NAME="vUSP-23804-P-01-snc1a"
       ;;

     "vnn1b")
       export OS_REGION_NAME="vnn1b"
       export OS_AUTH_URL=https://identity-aic-vnn1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="f9f1b81cb3284b9fa187d5b8d5bffc08"
       export OS_TENANT_NAME="vUSP-23804-P-01-vnn1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-vnn1b" 
       ;;

     "wah1b")
       export OS_REGION_NAME="wah1b"
       export OS_AUTH_URL=https://identity-aic-wah1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="4c27f90d070a45d783a76ff8f08e6465"
       export OS_TENANT_NAME="vUSP-23804-P-01-wah1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-wah1b"
       ;;

     "whp1b")
       export OS_REGION_NAME="whp1b"
       export OS_AUTH_URL=https://identity-aic-whp1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="a1cd06bcf0cb4d8d9dc49fc536d9111f"
       export OS_TENANT_NAME="vUSP-23804-P-01-whp1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-whp1b"
       ;;

     "wnd1a")
       export OS_REGION_NAME="wnd1a"
       export OS_AUTH_URL=https://identity-aic-wnd1a.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_ID="a0f3d5c96b904413bee58405460c2005"
       export OS_TENANT_NAME="vUSP-23804-P-01-wnd1a"
       export OS_PROJECT_NAME="vUSP-23804-P-01-wnd1a"
       ;;

     "wnd1b")
       export OS_REGION_NAME="wnd1b"
       export OS_AUTH_URL=https://identity-aic-wnd1b.dcp.aic.att.com:5000/v2.0
       export OS_TENANT_NAME="vUSP-23804-P-01-wnd1b"
       export OS_PROJECT_NAME="vUSP-23804-P-01-wnd1b"
       ;;
     *)
       echo "Selection '$ANS' invalid!"
       echo
       ;;

   esac
}

if [ "x$REGION" == "x" ]
 then
  menu
else
  source ~/.openstack $OS1 $OS2
  set_env $REGION
fi

echo

if [ "x$OS_USERNAME" == "x" ]
 then
  echo -e "   Enter your OpenStack User: \c"
  read USERNAME
  export OS_USERNAME=$USERNAME
  echo
fi

if [ "x$OS_PASSWORD" == "x" ]
 then
  echo -e "   Please enter your OpenStack Password: \c"
  read -sr OS_PASSWORD_INPUT
  export OS_PASSWORD=$OS_PASSWORD_INPUT
  echo
fi
echo


# Don't leave a blank variable, unset it if it was empty
if [ -z "$OS_REGION_NAME" ] 
 then 
  unset OS_REGION_NAME
  echo "exiting..."
  echo
  exit
fi

echo "   Using the following:"
echo 
echo "      User Name: $OS_USERNAME"
echo "      Tenant Name: $OS_TENANT_NAME"
echo "      Region Name: $OS_REGION_NAME"
echo 
echo

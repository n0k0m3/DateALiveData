import urllib.request
import urllib.parse
import xml.etree.ElementTree as ET
from pkg_resources import parse_version as pv
import os
import json
from zipfile import ZipFile
import subprocess
from shutil import rmtree
import re
import time

url = "http://c-dal-ml.heitaoglobal.com/dal_global/test/"
# http://c-ml.datealive.com/dal_global/release_android/
# http://c-dal-ml.heitaoglobal.com/dal_global/release_android/
# Open remove check.xml
checkxml = urllib.request.urlopen(
    urllib.parse.urljoin(url, "check.xml")).read()
checkxml = re.sub(r"&",r"&amp;",checkxml.decode("utf-8"))
check_version = ET.fromstring(checkxml)

with open("./DateALiveData/version.txt", "r") as f:
    curver = f.read()

server_appversion, server_current, server_minversion = [
    v for k, v in check_version.attrib.items()][:3]
for lang in check_version:
    if lang.tag == "announcement_english":
        content = lang.attrib["content"]

def regex_format_commitmsg(content):
    title = "Version: {} | ToVersion: {} | AppVersion: {}\n".format(curver,server_current,server_appversion)
    s = re.sub(r"(\[)","\\n\\1",content, 0, re.MULTILINE)
    s = re.sub(r" (\d\.)","\\n\\1",s, 0, re.MULTILINE)
    s = re.sub(r"(\s\s\s+)","\\n\\1",s, 0, re.MULTILINE)
    s = re.sub(r"\s+(\-\S)","\\n   \\1",s, 0, re.MULTILINE)
    return(title+s.lstrip())

commit_msg = regex_format_commitmsg(content)

# If current version if old then update
if pv(curver) < pv(server_current):
    filename = curver+"-"+server_current+".zip"
    relative_path = "/".join(["zipsource", server_current, filename])

    # Download the zip update file
    r = urllib.request.urlretrieve(
        urllib.parse.urljoin(url, relative_path), filename)
    basename = os.path.splitext(filename)[0]

    # Extract zip file to the correct folder
    with ZipFile(filename, 'r') as zipObj:
        zipObj.extractall(basename)

    # Decrypt unzipped update to the repo
    decrypt = ["python", r"DALSP-Assets-Decryption-tool/main.py", 
               basename, "DateALiveData", "-w", "-v"]
    with subprocess.Popen(decrypt) as p1:
        pass

    # Remove trash
    os.remove(filename)
    rmtree(basename)

    # Write check file
    with open("./DateALiveData/version.txt", "w+") as f:
        f.write(server_current)

    # Git commit
    os.chdir("DateALiveData")
    gitadd = ["git", "add", "."]
    subprocess.run(gitadd)

    gitcommit = ["git", "commit", "-m", commit_msg]
    subprocess.run(gitcommit)

    gitpush = ["git", "push"]
    subprocess.run(gitpush)

    os.chdir("..")

elif pv(curver) == pv(server_current):
    print("Current version is the same as the server version")
else:
    print("Something went wrong, version mismatch")

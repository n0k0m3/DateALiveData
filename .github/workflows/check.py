import urllib.request
import urllib.parse
import xml.etree.ElementTree as ET
from pkg_resources import parse_version as pv
import os
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
with open("version.txt", "r") as f:
    curver = f.read()

server_appversion, server_current, server_minversion = [
    v for k, v in check_version.attrib.items()][:3]
for lang in check_version:
    if lang.tag == "announcement_english":
        content = lang.attrib["content"]

# If current version if old then update
if pv(curver) < pv(server_current):
    os.system('echo \"::set-output name=test::true\"')
elif pv(curver) == pv(server_current):
    os.system('echo \"::set-output name=test::false\"')
else:
    os.system('echo \"::set-output name=test::error\"')

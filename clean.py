from os import listdir
from os.path import isfile, join
mypath = "swift_api/lib/api"
models = [f for f in listdir(mypath) if isfile(join(mypath, f))]
for m in models:
	f = open(mypath+'/'+m)
	content = f.read()
	newContent = content.replace("import 'package:swift_API/model/one_of&lt;response_string,object&gt;.dart';","")
	f.close()
	f = open(mypath+'/'+m,"w")
	f.write(newContent)
	f.close()
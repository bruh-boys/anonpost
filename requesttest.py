import requests
# im using this simple file for test the requests of the service
# its a little bit shitty i know 
r=requests.post("http://localhost:8080/board")
formvalues={"username":"test","title":"test","body":"test"}

r=requests.post("http://localhost:8080/board",formvalues)
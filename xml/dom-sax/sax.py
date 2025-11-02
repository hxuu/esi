#!/usr/bin/env python3

# SAX (simple API for XML) is event driven
# ie, you react to events like "start of a tag", "text inside a tag", "end of a tag".
from xml.sax import make_parser, handler

class EmployeHandler(handler.ContentHandler):
    # reference: https://docs.python.org/3/library/xml.sax.handler.html#xml.sax.handler.ContentHandler
    # A callback interface is a set of methods that your code must implement
    def __init__(self):
        self.current_tag = ""
        self.current_employee = {}
        self.employees = []

    def startElement(self, name, attrs):
        # reference: https://docs.python.org/3/library/xml.sax.handler.html#xml.sax.handler.ContentHandler.startElement
        self.current_tag = name
        if name == "Employe":
            self.current_employee = {}

    def characters(self, content):
        # reference: https://docs.python.org/3/library/xml.sax.handler.html#xml.sax.handler.ContentHandler.characters
        if self.current_tag in ['Mat', 'Nom', 'Prenom', 'Date-de-Naissance', 'Service']:
            content = content.strip()
            if content:
                self.current_employee[self.current_tag] = content

    def endElement(self, name):
        # reference: https://docs.python.org/3/library/xml.sax.handler.html#xml.sax.handler.ContentHandler.startElement
        if name == "Employe":
            self.employees.append(self.current_employee)
        self.current_tag = ""

# init
# reference: https://docs.python.org/3/library/xml.sax.html#xml.sax.make_parser
parser = make_parser()
handler = EmployeHandler()
parser.setContentHandler(handler)

parser.parse('./results/Employes_modified.xml')

# handler.employees now contains the list of all employees
employees = handler.employees

# (a) List employees sorted alphabetically by 'Nom'
print("\n--- (a) Employees sorted by Nom ---")
for emp in sorted(employees, key=lambda x: x.get('Nom', '')):
    print(f"{emp['Nom']} {emp['Prenom']}")

# (b) List employees of Service2
print("\n--- (b) Employees in Service2 ---")
for emp in employees:
    if emp['Service'] == 'Service2':
        print(f"{emp['Nom']} {emp['Prenom']}")

# (c) Employees of Service3 born after 1970
print("\n--- (c) Employees in Service3 and born after 1970 ---")
for emp in employees:
    if emp['Service'] == 'Service3':
        year = int(emp['Date-de-Naissance'].split('-')[2])
        if year > 1970:
            print(f"{emp['Nom']} {emp['Prenom']}")

# (d) Number of employees per service
print("\n--- (d) Number of employees per Service ---")
service_count = {}

for emp in employees:
    service = emp['Service']
    service_count[service] = service_count.get(service, 0) + 1

for service, count in service_count.items():
    print(f"{service}: {count} employee(s)")


#!/usr/bin/env python3

from xml.dom.minidom import parse, parseString, Document

# dom = parse('./Championnat.xml')
# print(dom)

# # Step1: generate the base Employes.xml
# doc = Document()
#
# root = doc.createElement('Employes')
# doc.appendChild(root)
#
# employees = [
#     ('E05', 'Kadri', 'Amina', '23-11-1995', 'S3'),
#     ('E04', 'Abelmalk', 'Hakima', '18-10-1977', 'S3'),
#     ('E01', 'Nouar', 'Mohamed', '08-04-1975', 'S1'),
#     ('E02', 'Benali', 'Mostapha', '06-07-1965', 'S2'),
#     ('E06', 'Safi', 'Mostapha', '23-12-1966', 'S4'),
#     ('E03', 'Drissi', 'Oussama', '21-09-1956', 'S2'),
#     ('E07', 'Nadji', 'Youssef', '31-12-1985', 'S4'),
# ]
#
# # build each employee node
# for mat, nom, prenom, date_n, service in employees:
#     employe = doc.createElement('Employe')
#     # print(doc.toprettyxml(indent='  '))
#     # break
#
#     mat_elem = doc.createElement('Mat')
#     mat_elem.appendChild(doc.createTextNode(mat))
#
#     nom_elem = doc.createElement('Nom')
#     nom_elem.appendChild(doc.createTextNode(nom))
#
#     prenom_elem = doc.createElement('Prenom')
#     prenom_elem.appendChild(doc.createTextNode(prenom))
#
#     date_n_elem = doc.createElement('Date_N')
#     date_n_elem.appendChild(doc.createTextNode(date_n))
#
#     service_elem = doc.createElement('Service')
#     service_elem.appendChild(doc.createTextNode(service))
#
#     employe.appendChild(mat_elem)
#     employe.appendChild(nom_elem)
#     employe.appendChild(prenom_elem)
#     employe.appendChild(date_n_elem)
#     employe.appendChild(service_elem)
#
#     root.appendChild(employe)
#
# #!/usr/bin/env python3
#
# from xml.dom.minidom import parse, parseString, Document
#
# # dom = parse('./Championnat.xml')
# # print(dom)
#
# # Step1: generate the base Employes.xml
# doc = Document()
#
# root = doc.createElement('Employes')
# doc.appendChild(root)
#
# employees = [
#     ('E05', 'Kadri', 'Amina', '23-11-1995', 'S3'),
#     ('E04', 'Abelmalk', 'Hakima', '18-10-1977', 'S3'),
#     ('E01', 'Nouar', 'Mohamed', '08-04-1975', 'S1'),
#     ('E02', 'Benali', 'Mostapha', '06-07-1965', 'S2'),
#     ('E06', 'Safi', 'Mostapha', '23-12-1966', 'S4'),
#     ('E03', 'Drissi', 'Oussama', '21-09-1956', 'S2'),
#     ('E07', 'Nadji', 'Youssef', '31-12-1985', 'S4'),
# ]
#
# # build each employee node
# for mat, nom, prenom, date_n, service in employees:
#     employe = doc.createElement('Employe')
#     # print(doc.toprettyxml(indent='  '))
#     # break
#
#     mat_elem = doc.createElement('Mat')
#     mat_elem.appendChild(doc.createTextNode(mat))
#
#     nom_elem = doc.createElement('Nom')
#     nom_elem.appendChild(doc.createTextNode(nom))
#
#     prenom_elem = doc.createElement('Prenom')
#     prenom_elem.appendChild(doc.createTextNode(prenom))
#
#     date_n_elem = doc.createElement('Date_N')
#     date_n_elem.appendChild(doc.createTextNode(date_n))
#
#     service_elem = doc.createElement('Service')
#     service_elem.appendChild(doc.createTextNode(service))
#
#     employe.appendChild(mat_elem)
#     employe.appendChild(nom_elem)
#     employe.appendChild(prenom_elem)
#     employe.appendChild(date_n_elem)
#     employe.appendChild(service_elem)
#
#     root.appendChild(employe)
#
#
# # with open('./results/Employes.xml', 'w', encoding='utf-8') as f:
# #     f.write(doc.toprettyxml(indent='    '))


# # Step2: modify the existing Employes.xml
# dom = parse('./results/Employes.xml')
#
# # reference: https://docs.python.org/3/library/xml.dom.html#xml.dom.Document.documentElement
# root = dom.documentElement
#
# # (a) Add the new employee
# new_employe = dom.createElement('Employe')
#
# mat_elem = dom.createElement('Mat')
# mat_elem.appendChild(dom.createTextNode('E08'))
#
# nom_elem = dom.createElement('Nom')
# nom_elem.appendChild(dom.createTextNode('Tahar'))
#
# prenom_elem = dom.createElement('Prenom')
# prenom_elem.appendChild(dom.createTextNode('Zakaria'))
#
# date_elem = dom.createElement('Date_N')
# date_elem.appendChild(dom.createTextNode('24-08-1995'))
#
# service_elem = dom.createElement('Service')
# service_elem.appendChild(dom.createTextNode('S3'))
#
# new_employe.appendChild(mat_elem)
# new_employe.appendChild(nom_elem)
# new_employe.appendChild(prenom_elem)
# new_employe.appendChild(date_elem)
# new_employe.appendChild(service_elem)
#
# # reference: https://docs.python.org/3/library/xml.dom.html#xml.dom.Node.appendChild
# root.appendChild(new_employe)
#
# # (b) + (c) Add Grade attribute and rename Service values
# # reference: https://docs.python.org/3/library/xml.dom.html#xml.dom.Document.getElementsByTagName
# for service in root.getElementsByTagName('Service'):
#     service_text = service.firstChild.nodeValue
#
#     # Map old S1, S2... to Service1, Service2...
#     if service_text.startswith('S') and service_text[1:].isdigit():
#         service_num = service_text[1:]
#         service.firstChild.nodeValue = f'Service{service_num}'
#
#     # Add Grade attribute
#     if service_text == 'S1' or service_text == 'Service1':
#         # reference: https://docs.python.org/3/library/xml.dom.html#xml.dom.Element.setAttribute
#         service.setAttribute('Grade', 'Ingenieur')
#     elif service_text == 'S2' or service_text == 'Service2':
#         service.setAttribute('Grade', 'Administrateur')
#     elif service_text == 'S3' or service_text == 'Service3':
#         service.setAttribute('Grade', 'Technicien')
#     else:
#         service.setAttribute('Grade', 'Agent')
#
# # (d) Rename <Date_N> to <Date-de-Naissance>
# for employe in root.getElementsByTagName('Employe'):
#     # reference: https://docs.python.org/3/library/xml.dom.html#xml.dom.Node.childNodes
#     for child in employe.childNodes:
#         if child.nodeType == child.ELEMENT_NODE and child.tagName == 'Date_N':
#             # Create a new element
#             new_date = dom.createElement('Date-de-Naissance')
#             new_date.appendChild(dom.createTextNode(child.firstChild.nodeValue))
#             employe.replaceChild(new_date, child)
#
# # (e) Delete employee with Mat == E07
# to_remove = []
# for employe in root.getElementsByTagName('Employe'):
#     mat = employe.getElementsByTagName('Mat')[0]
#     if mat.firstChild.nodeValue == 'E07':
#         to_remove.append(employe)
#
# for emp in to_remove:
#     # reference: https://docs.python.org/3/library/xml.dom.html#xml.dom.Node.removeChild
#     root.removeChild(emp)
#
# # (f) Delete employees born before 1970
# to_remove_birth = []
# for employe in root.getElementsByTagName('Employe'):
#     date_elem = employe.getElementsByTagName('Date-de-Naissance')[0]
#     birth_date = date_elem.firstChild.nodeValue  # format: DD-MM-YYYY
#     year = int(birth_date.split('-')[2])
#     if year < 1970:
#         to_remove_birth.append(employe)
#
# for emp in to_remove_birth:
#     root.removeChild(emp)
#
# # Save modified file
# with open('./results/Employes_modified.xml', 'w', encoding='utf-8') as f:
#     f.write(dom.toprettyxml(indent='    '))


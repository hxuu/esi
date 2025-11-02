#!/usr/bin/env bash

USERNAME=alice
PASSWORD=pass123
BASE_URL=http://localhost:8080

echo "=== Creating child for admission test ==="
create_child_response=$(curl -s -X POST $BASE_URL/api/children \
  -u $USERNAME:$PASSWORD \
  -H "Content-Type: application/json" \
  -d '{"name":"John Doe","dateOfBirth":"2018-04-22","contactInfo":"parent@example.com","allergies":"none","specialNeeds":"none"}')

child_id=$(echo $create_child_response | jq -r '.id')
echo "Child created with ID: $child_id"

echo
echo "=== Creating admission for the child ==="
create_admission_response=$(curl -s -X POST $BASE_URL/api/admissions \
  -u $USERNAME:$PASSWORD \
  -H "Content-Type: application/json" \
  -d "{\"child\":{\"id\":\"$child_id\"},\"status\":\"WAITING\"}" | jq)

admission_id=$(echo $create_admission_response | jq -r '.id')
echo "Admission created with ID: $admission_id"

echo
echo "=== Fetching admission by ID ==="
curl -s -u $USERNAME:$PASSWORD $BASE_URL/api/admissions/$admission_id | jq
echo

echo
echo "=== Updating admission status to VALIDATED ==="
curl -s -X PUT $BASE_URL/api/admissions/$admission_id \
  -u $USERNAME:$PASSWORD \
  -H "Content-Type: application/json" \
  -d "{\"child\":{\"id\":\"$child_id\"},\"status\":\"VALIDATED\"}" | jq
echo

echo
echo "=== Deleting admission ==="
curl -s -X DELETE $BASE_URL/api/admissions/$admission_id \
  -u $USERNAME:$PASSWORD
echo

echo
echo "=== Confirming deletion (should return 404) ==="
curl -s -o /dev/null -w "%{http_code}" -u $USERNAME:$PASSWORD $BASE_URL/api/admissions/$admission_id
echo


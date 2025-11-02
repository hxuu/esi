#!/usr/bin/env bash

echo 'Testing authentication functionality'
echo

# Signup as educator
curl -X POST http://localhost:8080/api/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"username":"alice","password":"pass123","role":"educator"}'

echo
echo =========================================================================

echo 'Accessing protected route as alice'
echo

# Access protected route
curl -u alice:pass123 http://localhost:8080/educator/dashboard

echo
echo =========================================================================

echo 'Testing children profile management (creation/listing...)'
echo

# Add a child
echo 'Creating child profile for Emma...'
CREATE_RESPONSE=$(curl -s -X POST http://localhost:8080/api/children \
  -H "Content-Type: application/json" \
  -u alice:pass123 \
  -d '{"name":"Emma","dateOfBirth":"2020-05-10","contactInfo":"emma.parent@example.com","allergies":"peanuts","specialNeeds":"speech therapy"}')

echo "$CREATE_RESPONSE"

# Extract ID from the response (assumes JSON output with an "id" field)
CHILD_ID=$(echo "$CREATE_RESPONSE" | grep -oP '"id"\s*:\s*"\K[^"]+')

echo
echo 'Created child with ID: '"$CHILD_ID"
echo =========================================================================

echo 'Retrieving list of all children...'
curl -s -u alice:pass123 http://localhost:8080/api/children | jq .
echo =========================================================================

echo 'Retrieving single child by ID...'
curl -s -u alice:pass123 http://localhost:8080/api/children/$CHILD_ID | jq .
echo =========================================================================

echo 'Updating child info (changing contactInfo)...'
echo

curl -X PUT http://localhost:8080/api/children/$CHILD_ID \
  -H "Content-Type: application/json" \
  -u alice:pass123 \
  -d '{
        "name": "Emma",
        "dateOfBirth": "2020-05-10",
        "contactInfo": "updated.email@example.com",
        "allergies": "peanuts",
        "specialNeeds": "speech therapy"
      }'

echo
echo =========================================================================

echo 'Deleting child...'
echo
curl -s -X DELETE http://localhost:8080/api/children/$CHILD_ID \
  -u alice:pass123
echo
echo =========================================================================

echo 'Trying to fetch deleted child (should return 404)...'
echo
curl -s -o /dev/null -w "%{http_code}\n" -u alice:pass123 http://localhost:8080/api/children/$CHILD_ID
echo =========================================================================


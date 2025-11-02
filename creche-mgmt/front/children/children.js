const apiBase = 'http://localhost:8080/api/children';
let authHeader = {};

function loadAuth() {
  const stored = localStorage.getItem('auth');
  if (stored) authHeader = { 'Authorization': 'Basic ' + btoa(stored) };
}

function fetchChildren() {
  fetch(apiBase, { headers: authHeader })
    .then(res => res.json())
    .then(data => {
      let table = '<table class="table table-striped"><thead><tr><th>Name</th><th>DOB</th><th>Contact</th><th>Allergies</th><th>Needs</th><th>Actions</th></tr></thead><tbody>';
      data.forEach(c => {
        table += `<tr>
          <td>${c.name}</td>
          <td>${c.dateOfBirth}</td>
          <td>${c.contactInfo}</td>
          <td>${c.allergies}</td>
          <td>${c.specialNeeds}</td>
          <td>
            <button onclick="editChild('${c.id}')" class="btn btn-sm btn-warning">Edit</button>
            <button onclick="deleteChild('${c.id}')" class="btn btn-sm btn-danger">Delete</button>
          </td>
        </tr>`;
      });
      table += '</tbody></table>';
      document.getElementById('children-list').innerHTML = table;
    });
}

function editChild(id) {
  fetch(`${apiBase}/${id}`, { headers: authHeader })
    .then(res => res.json())
    .then(c => {
      document.getElementById('name').value = c.name;
      document.getElementById('dob').value = c.dateOfBirth;
      document.getElementById('contact').value = c.contactInfo;
      document.getElementById('allergies').value = c.allergies;
      document.getElementById('needs').value = c.specialNeeds;
      document.getElementById('child-form').setAttribute('data-id', c.id);
    });
}

function deleteChild(id) {
  fetch(`${apiBase}/${id}`, { method: 'DELETE', headers: authHeader })
    .then(() => fetchChildren());
}

function handleSubmit(e) {
  e.preventDefault();
  const id = e.target.getAttribute('data-id');
  const method = id ? 'PUT' : 'POST';
  const url = id ? `${apiBase}/${id}` : apiBase;
  const body = {
    name: document.getElementById('name').value,
    dateOfBirth: document.getElementById('dob').value,
    contactInfo: document.getElementById('contact').value,
    allergies: document.getElementById('allergies').value,
    specialNeeds: document.getElementById('needs').value
  };

  fetch(url, {
    method,
    headers: {
      'Content-Type': 'application/json',
      ...authHeader
    },
    body: JSON.stringify(body)
  }).then(() => {
    e.target.reset();
    e.target.removeAttribute('data-id');
    fetchChildren();
  });
}

document.getElementById('child-form').addEventListener('submit', handleSubmit);

loadAuth();
fetchChildren();

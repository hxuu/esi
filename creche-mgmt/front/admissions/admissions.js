const admissionApi = 'http://localhost:8080/api/admissions';
let authHeader = {};

function loadAuth() {
  const stored = localStorage.getItem('auth');
  if (stored) authHeader = { 'Authorization': 'Basic ' + btoa(stored) };
}

function fetchAdmissions() {
  fetch(admissionApi, { headers: authHeader })
    .then(res => res.json())
    .then(data => {
      let table = '<table class="table table-bordered"><thead><tr><th>ID</th><th>Child Name</th><th>Status</th><th>Actions</th></tr></thead><tbody>';
      data.forEach(a => {
        table += `<tr>
          <td>${a.id}</td>
          <td>${a.child.id}</td>
          <td>${a.status}</td>
          <td>
            <button onclick="editAdmission('${a.id}', '${a.child.id}', '${a.status}')" class="btn btn-sm btn-warning">Edit</button>
            <button onclick="deleteAdmission('${a.id}')" class="btn btn-sm btn-danger">Delete</button>
          </td>
        </tr>`;
      });
      table += '</tbody></table>';
      document.getElementById('admissions-list').innerHTML = table;
    });
}

function editAdmission(id, childId, status) {
  document.getElementById('childId').value = childId;
  document.getElementById('status').value = status;
  document.getElementById('admission-form').setAttribute('data-id', id);
}

function deleteAdmission(id) {
  fetch(`${admissionApi}/${id}`, { method: 'DELETE', headers: authHeader })
    .then(() => fetchAdmissions());
}

function handleSubmit(e) {
  e.preventDefault();
  const id = e.target.getAttribute('data-id');
  const method = id ? 'PUT' : 'POST';
  const url = id ? `${admissionApi}/${id}` : admissionApi;
  const body = {
    child: { id: document.getElementById('childId').value },
    status: document.getElementById('status').value
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
    fetchAdmissions();
  });
}

document.getElementById('admission-form').addEventListener('submit', handleSubmit);

loadAuth();
fetchAdmissions();


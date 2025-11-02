const API_BASE = 'http://localhost:8080/api';

document.getElementById('signup-form').addEventListener('submit', async function (e) {
  e.preventDefault();
  const username = document.getElementById('signup-username').value;
  const password = document.getElementById('signup-password').value;
  const role = document.getElementById('signup-role').value;

  const response = await fetch(`${API_BASE}/auth/signup`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password, role })
  });

  if (response.ok) {
    alert('Sign-up successful!');
    // Save role in localStorage for login redirection
    localStorage.setItem(`role:${username}`, role);
    e.target.reset();
  } else {
    alert('Sign-up failed.');
  }
});

document.getElementById('login-form').addEventListener('submit', async function (e) {
  e.preventDefault();
  const username = document.getElementById('login-username').value;
  const password = document.getElementById('login-password').value;
  const role = localStorage.getItem(`role:${username}`);

  const statusDiv = document.getElementById('login-status');

  if (!role) {
    statusDiv.innerHTML = '<div class="alert alert-danger">Role not found. Did you sign up?</div>';
    return;
  }

  const authHeader = 'Basic ' + btoa(`${username}:${password}`);

  const response = await fetch(`http://localhost:8080/${role}/dashboard`, {
    headers: {
      'Authorization': authHeader
    }
  });

  if (response.ok) {
    localStorage.setItem('auth', `${username}:${password}`);
    statusDiv.innerHTML = '<div class="alert alert-success">Login successful</div>';
    e.target.reset();

    // Redirect to role-based dashboard
    // window.location.href = `/${role}/dashboard`;
  } else {
    statusDiv.innerHTML = '<div class="alert alert-danger">Login failed</div>';
  }
});


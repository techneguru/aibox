import os
c = get_config()

# NativeAuthenticator for brukernavn/passord
c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator'

# Admin user fra environment:
admin_user = os.getenv("JUPYTERHUB_ADMIN_USER", "admin")
admin_pw = os.getenv("JUPYTERHUB_ADMIN_PW", "adminpw")

# Gi NativeAuthenticator lov til å la brukere registrere seg:
c.NativeAuthenticator.open_signup = True

# Hvor JupyterHub lagrer sin DB (bruker+token info)
c.JupyterHub.db_url = "/srv/jupyterhub/jhub.sqlite"

# Hvem er admin?
c.Authenticator.admin_users = {admin_user}

# Du kan evt. auto-opprette admin-bruker ved oppstart
# (mer avansert script, men ofte gjøres manuelt i UI)

# Standard spawner -> jupyterlab
c.Spawner.default_url = "/lab"

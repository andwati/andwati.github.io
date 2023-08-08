+++
title = "Django Secret Key Tutorial"
description = "Managing secrets"
date = 2022-11-11T15:34:14.160Z
[taxonomies]
tags = ["tutorial", "Django", "Python", ".emv"]
+++

Managing the Django SECRET_KEY variable.

<!-- more -->

The Django `SECRET_KEY` variable is very crucial to your Django application. The secret key must be a large random value and it must be kept secret. Leaking this value to unauthorized people could lead to a security breach. The SECRET_KEY is used in Django for cryptographic signing. It is used to generate tokens and hashes, they can be recreated using this variable. If it is not configured Django throws a `django.core.exceptions.ImproperlyConfigured: The SECRET_KEY setting must not be empty` error

# Using Environment Variables

The secret key should not be committed to version control. It is best practice to store the value in a .env file which is added to the .gitignore file to un-track its changes. The values can be loaded programmatically into your settings.py file.

# Generating A New Secret Key

This solution is using python's secrets lib on the back

```python
from django.core.management.utils import get_random_secret_key
# print new random secret key
print(get_random_secret_key())
```

This code can be run in the terminal as a command:

```python
python -c 'from django.core.management.utils import get_random_secret_key; \
            print(get_random_secret_key())'
```

Alternatively, If you are using python 3.6+ then you can use the `secrets.token_hex(\[nbytes=None])` function:

```python
python3 -c 'import secrets; print(secrets.token_hex(100))'
```

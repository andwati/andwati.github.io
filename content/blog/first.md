+++
title = "My first post"
date = 2023-08-01
+++

This is my first blog post

```python
from django.db import model

classs Question(model.Model):
    quesion_text = models.Charfield(max_length=200)

    def __str__(self):
        return self.question_text
```

---
layout: default
title: Links
---

# A Collection Of Links That I Find Interesting

I'll work on an organization scheme as this list grows.

<ul>
    {% for link in site.data.links.links %}
        {% assign slug = link.title | slugify %}
        <li id="{{ slug }}">
            <a href="{{ link.url}}" target="_blank">{{ link.title }}</a> <a href="{{ slug | prepend: '#' }}">🔗</a>
        </li>
    {% endfor %}
</ul>

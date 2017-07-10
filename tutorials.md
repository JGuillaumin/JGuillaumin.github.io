---
layout: page
title: "Hi, I'm Julien"
subtitle: Student At Télécom Bretagne / Deep Learning Developer / MOOC friendly
css: "/css/index.css"
meta-title: "Julien Guillaumin - Algorithm Developer"
meta-description: "Algorithm developer for Machine Learning and Deep Learning (Theano, Keras, Caffe). Student at Télécom Beratgne - MSc Applied Mathematics"
bigimg:
  - "/img/big-imgs/dalbosc.png" : "Dalbosc, France (2014)"
---

<div class="list-filters">
  <a href="/" class="list-filter">All posts</a>
  <a href="/moocs" class="list-filter">MOOCs</a>
  <span class="list-filter filter-selected">Tutorials</span>
</div>

<div class="posts-list">
  {% for post in site.tags.tutorial %}
  <article>
    <a class="post-preview" href="{{ post.url | prepend: site.baseurl }}">
	    <h2 class="post-title">{{ post.title }}</h2>
	
	    {% if post.subtitle %}
	    <h3 class="post-subtitle">
	      {{ post.subtitle }}
	    </h3>
	    {% endif %}
      <p class="post-meta">
        Posted on {{ post.date | date: "%B %-d, %Y" }}
      </p>

      <div class="post-entry">
        {{ post.content | truncatewords: 50 | strip_html | xml_escape}}
        <span href="{{ post.url | prepend: site.baseurl }}" class="post-read-more">[Read&nbsp;More]</span>
      </div>
    </a>  
   </article>
  {% endfor %}
</div>

#!/usr/bin/python

# Katacoda to Instruqt converter

# v. 0.0.1

import os
import json
import yaml
import re

track_d={}

with open('../using-the-cluster-pathway.json', 'r') as myfile:
    data=myfile.read()

courses = json.loads(data)

for course in courses['courses']:
    pathway_id=course['pathway_id']
    course_id=course['course_id']
    title=course['title']
    
    trackDir=course_id
    
    
    track_d["title"] = title
    track_d["slug"] = course_id
    track_d["type"] = "truck"
    
    if not os.path.exists(trackDir):
      os.mkdir(trackDir)
      print("Directory " , trackDir ,  " Created ")
    else:    
      print("Directory " , trackDir ,  " already exists")
      
    with open('../' + pathway_id + '/' + course_id + '/index.json', 'r') as mycourse:
        course_data=mycourse.read()
    
    course_json = json.loads(course_data)
    
    track_d["icon"] = "https://logodix.com/logo/1910931.png"
    track_d["level"] = "beginner"
    track_d["tags"] = ["openshift"]
    track_d["owner"] = ["openshift"]
    track_d["developers"] = [ "btannous@redhat.com", "nvinto@redhat.com","rjarvine@redhat.com"]
    track_d["private"] =  "false"
    track_d["published"] = "true"
    track_d["skipping_enabled"] = "true"
    
    difficulty="intermediate"
    # course_json["time"]
    time="300"
    
    if course_json["difficulty"] == "beginner":
      difficulty="basic"
  
        
    l_challenges=[]
    d_challenges={}
    
    for step in course_json["details"]["steps"]:
        slug = step["text"]
        slug = re.sub(r'\.md$', '', slug )
        d_challenges["slug"] = slug
        d_challenges["title"] = step["title"]
        d_challenges["type"] = "challenge"
        
        with open('../' + pathway_id + '/' + course_id + '/' + step["text"], 'r') as myassign:
            assign_data=myassign.read()
        
        md=re.sub(r'`{1,2}(.*)`{1,3}\{\{execute\}\}', r'```\n\1\n```', assign_data )
        md=re.sub(r'\{\{copy\}\}',r'', md)
        md=re.sub(r'\(\.\.\/\.\.\/assets',r'(https://katacoda.com/openshift/assets',md)
        
        d_challenges["assignment"] =  md
        
        d_challenges["tabs"] = [{"title": "cli", "type": "terminal","hostname":"crc-nonest-1"},
                                {"title": "web-ui", "type" : "service", "hostname" : "crc-nonest-1", "port" : "30443"}]
        
        d_challenges["difficulty"]= difficulty
        d_challenges["timelimit"]= time
        
        dictionary_copy = d_challenges. copy()
        l_challenges.append(dictionary_copy);
        


    
    track_d["challenges"] = l_challenges
    
    with open(trackDir + '/track.yml', 'w') as yaml_file:
      yaml.dump(track_d, yaml_file, default_flow_style=False)




    



# Data Engineer Concepts - Solution

___
**1. What do you think is important to consider before ingesting data into a
   pre-existing reporting structure? What questions would you ask? What
   information would you seek?**

* First understand the broader context
  * What is the business context, objectives, goals with the data?   Has the process been done before, if so, how was it done? What tools and resources have been used? And there are precedents of past solutions to obviously take advantage of the progress that has already been made.   What are the required times and how often should it be done?
* Then begin to understand the underlying data
  * What is the schema? What are the data types? What is the business context, objectives, goals with the data? Do we have sensitive, private information, or does it imply any additional security? 
* Then move into how it is implemented
  * What tools and resources have been used?
  * Do you use an orchestration tool like Airflow or Prefect?

___

**2. How would you build consensus around making changes to data processing or
   pipelines with other members of a multidisciplinary team? How do you know
   when you have an agreement to move forward? What might you consider when
   presenting your proposal to the team?**

* Call a meeting with the multidisciplinary team to discuss the changes. 
  * Before the meeting, make sure that have heard from key stakeholders and that there is alignment on a potential solution. If alignment is not possible, then will need to explain why we are moving in a specific direction.
* Present Tech arguments and show evidence of my solution and other approaches through diagrams, code samples, demos, etc. 
* Highlight the benefits and possible disadvantages of my approach.
* Discuss and get verbal agreement from team members and after the meeting write an email to summarize the main points from the meeting and to ask everybody to confirm that they agree with the next steps. 
* I would consider the fact that my team is multidisciplinary and therefore the level of technical knowledge will vary. I will present in a clear and concise way to communicate the message as best as possible. 
* Also considering the experience of my team, I would like to get their opinions and feedback to improve my proposal and be conscious about risks or possible problems. 

___

**3. How do you know if you have “good data?” How would you approach cleaning data
   to make it "good data?"**

* Data is very rarely perfect. So we need prioritize the cleanliness and accuracy and completeness of the data based on business needs.  
* To know that I have good data, First, I know the context of the data. I like to observe very well and use different 
functions and verify the data types are correct, otherwise force the change to see if the data accepts the new type of data, 
 all this to see if it adjusts to reality and has the integrity required by the organization or business context derived from its policies. 
* With the first context I will proceed to remove duplicate data using DISTINCT, GROUPBY, duplicate() function in pandas or other techniques. It’s important to also deal well with the missing data and Null values. Each column must be treated differently, so there must be a very clear context, taking into account the objective of the analysis to know if it can impact the result or not. 
* For repetitive tasks, I could develop tests that contribute to validating and raising the quality of the data, looking for it to preserve its logic and meaning, complying with integrity rules.


#### By: Alex Torres
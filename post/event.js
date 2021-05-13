
// event Month starts counting from "0". if you mean to put January, put "0" for Month parameter
var events = [
    // 1st presentation was Feb 27, 2021, it is (year, month, date)
    {'Date': new Date(2021, 0, 25), 'Title': '2021 Spring begin', 'Link': 'https://www.csun.edu/'},
    {'Date': new Date(2021, 1, 27), 'Title': '1st Presentation', 'Link': 'https://docs.google.com/presentation/d/1-ooxyuAKUYwGlLDfuOfHZjXhbyeB3FzqNmywp6wdFo0/edit?usp=sharing'},
    {'Date': new Date(2021, 2, 27), 'Title': '2nd Presentation', 'Link': 'https://docs.google.com/presentation/d/1IukRYi8hZ8wmGB2wEY_l8NBGZBKNAmGleev-GBPsg5c/edit?usp=sharing'},
    {'Date': new Date(2021, 3, 22), 'Title': '3rd Presentation', 'Link': 'https://docs.google.com/presentation/d/1blFAd3OuYfK3GVBWQFk5oW9Jk7s0XCoOry83Xsssibw/edit?usp=sharing'},
    {'Date': new Date(2021, 4, 7), 'Title': 'Last day to register the Commencement'},
    {'Date': new Date(2021, 4, 15), 'Title': 'Final Presentation'},
    {'Date': new Date(2021, 4, 22), 'Title': 'Comp-Sci Dept Commencement', 'Link': 'https://www.csun.edu/current-students/graduation/commencement'},
  ];
  
  var settings = {};
  var element = document.getElementById('calendar');
  calendar(element, events, settings);
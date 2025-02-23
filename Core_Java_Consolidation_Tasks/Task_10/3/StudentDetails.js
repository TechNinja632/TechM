let student = {  
    name: "Rahul",  
    age: 20,  
    course: "CS",  
    getDetails: function() {  
        return `${this.name} (${this.age}) - ${this.course}`;  
    }  
};  

student.address = { city: "Chennai", pincode: 600081 };  
student.showAddress = function() { return `${this.address.city} - ${this.address.pincode}`; };  
student.greet = function() { console.log("Hello!"); };  

console.log(student.getDetails());  
console.log(student.showAddress());  

delete student.age;  
delete student.greet;  
console.log(student);  
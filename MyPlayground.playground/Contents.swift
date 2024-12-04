struct Person {
    let name: String
    let age: Int
}

struct PeopleViewModel {
    var people: [Person]
    
    lazy var oldest: Person? = {
        return people.max(by: { $0.age < $1.age })
    }()
    
    init(people: [Person]) {
        self.people = people
        print("View model initialized")
    }
}

var viewModel = PeopleViewModel(people: [
    Person(name: "Adi", age: 30),
    Person(name: "Rian", age: 27),
    Person(name: "Tony", age: 26),
    Person(name: "Reza", age: 22)
])

viewModel.oldest?.name //
viewModel.people.append(Person(name: "Ray", age: 48))
viewModel.oldest?.name //
viewModel.people.append(Person(name: "Aziz", age: 45))
viewModel.oldest?.name //



class A {
    let a: Int = 1
    func run() {
        a
    }
}

class B: A {
    let b: Int = 2
    override func run() {
//        super.run()
        b
  }
}

class C: B {
    let c: Int = 3
    override func run() {
        super.run()
        c
    }
}

let c = C()
c.run()


class Address {
  var fullAddress: String
  var city: String
  
  init(fullAddress: String, city: String) {
    self.fullAddress = fullAddress
    self.city = city
  }
}

class Personx {
  var name: String
  var address: Address

  init(name: String, address: Address) {
    self.name = name
    self.address = address
  }
}

var headquarters = Address(fullAddress: "Sudirman", city: "Jakarta")
var andre = Personx(name: "Andre", address: headquarters)
var john = Personx(name: "John", address: headquarters)

//--
john.address.fullAddress = "Thamrinx"
//--
andre.address.fullAddress

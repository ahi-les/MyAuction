Status.create(name: 'Waiting to start')
Status.create(name: 'Active')
Status.create(name: 'Completed')

Delivery.create(name: 'Ukrposhta')
Delivery.create(name: 'Novaya pochta')
Delivery.create(name: 'Pickup')
Delivery.create(name: 'Other shipping methods')

Payment.create(name: 'Prepayment on the card')
Payment.create(name: 'C.O.D')
Payment.create(name: 'Cash payment')

Gender.create(name: 'Men\'s')
Gender.create(name: 'Women\'s')
Gender.create(name: 'Boys')
Gender.create(name: 'Girls')

Condition.create(name: 'New')
Condition.create(name: 'Used')
Condition.create(name: 'Stock')
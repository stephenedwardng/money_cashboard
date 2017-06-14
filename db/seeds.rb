require_relative('../models/transaction')
require_relative('../models/merchant')
require_relative('../models/tag')
require ('pry-byebug')


Transaction.delete_all()
Merchant.delete_all()
Tag.delete_all()

@merchant1 = Merchant.new({
  'name' => 'Asda'
  })

@merchant1.save()

@merchant2 = Merchant.new({
  'name' => 'TK Maxx'
  })

@merchant2.save()

@merchant3 = Merchant.new({
  'name' => 'EDF Energy'
  })

@merchant3.save()

@merchant4 = Merchant.new({
  'name' => 'Halfords'
  })

@merchant4.save()

@merchant5 = Merchant.new({
  'name' => 'HMV'
  })

@merchant5.save()

@tag1 = Tag.new({
  'type' => 'Food'
  })

@tag1.save()

@tag2 = Tag.new({
  'type' => 'Clothing'
  })

@tag2.save()

@tag3 = Tag.new({
  'type' => 'Home and Utilities'
  })

@tag3.save()

@tag4 = Tag.new({
  'type' => 'Motoring'
  })

@tag4.save()

@tag5 = Tag.new({
  'type' => 'Leisure'
  })

@tag5.save()

@transaction1 = Transaction.new({
  'item' => 'Pie',
  'value' => 4,
  'merchant_id' => @merchant1.id,
  'tag_id' => @tag1.id,
  'date_of_transaction' => '2017-01-11'
  })

@transaction1.save()

@transaction2 = Transaction.new({
  'item' => 'Jeans',
  'value' => 75,
  'merchant_id' => @merchant2.id,
  'tag_id' => @tag2.id,
  'date_of_transaction' => '2017-01-15'
  })

@transaction2.save()

@transaction3 = Transaction.new({
  'item' => 'Electricity',
  'value' => 80,
  'merchant_id' => @merchant3.id,
  'tag_id' => @tag3.id,
  'date_of_transaction' => '2017-02-06'
  })

@transaction3.save()

@transaction4 = Transaction.new({
  'item' => 'Pen',
  'value' => 260,
  'merchant_id' => @merchant2.id,
  'tag_id' => @tag5.id,
  'date_of_transaction' => '2017-03-08'
  })

@transaction4.save()

@transaction5 = Transaction.new({
  'item' => 'Pizza',
  'value' => 10,
  'merchant_id' => @merchant1.id,
  'tag_id' => @tag1.id,
  'date_of_transaction' => '2017-04-20'
  })

@transaction5.save()

@transaction6 = Transaction.new({
  'item' => 'Cup',
  'value' => 5,
  'merchant_id' => @merchant2.id,
  'tag_id' => @tag3.id,
  'date_of_transaction' => '2017-05-04'
  })

@transaction6.save()

@transaction7 = Transaction.new({
  'item' => 'Paper',
  'value' => 4,
  'merchant_id' => @merchant2.id,
  'tag_id' => @tag5.id,
  'date_of_transaction' => '2017-06-04'
  })

@transaction7.save()

binding.pry()
nil



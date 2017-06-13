require_relative('../db/sql_runner')
require_relative('./merchant')
require_relative('./tag')
require('date')
require('pry-byebug')

class Transaction

  attr_accessor :id, :item, :value, :merchant_id, :tag_id, :date_of_transaction

  def initialize(options)
    @id = options['id'].to_i()
    @item = options['item']
    @value = options['value'].to_f()
    @merchant_id = options['merchant_id'].to_i()
    @tag_id = options['tag_id'].to_i()
    @date_of_transaction = options['date_of_transaction']
  end

  def save()
    sql = "INSERT INTO transactions (item, value, merchant_id, tag_id, date_of_transaction)
    VALUES ('#{@item}', #{@value}, #{merchant_id}, #{tag_id}, '#{date_of_transaction}') RETURNING *;"
    transaction_data = SqlRunner.run(sql)
    @id = transaction_data.first['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM transactions;"
    transactions = SqlRunner.run(sql)
    result = transactions.map{|transaction| Transaction.new(transaction)}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = #{id};"
    transaction = SqlRunner.run(sql)
    result = Transaction.new(transaction.first)
    return result
  end

  # def update(options)
  #   sql = "UPDATE tags SET (item, value, merchant_id, tag_id, date_of_transaction) = ('#{@item}', #{@value}, #{merchant_id}, #{tag_id}, '#{date_of_transaction}') WHERE id = #{@id};"
  #   SqlRunner.run(sql)
  # end

  def update(options)
    sql = "UPDATE transactions 
    SET (item, value, merchant_id, tag_id, date_of_transaction) = ('#{options['item']}', #{options['value']}, '#{options['merchant_id']}', '#{options['tag_id']}', '#{options['date_of_transaction']}') 
    WHERE id = '#{options['id']}';"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM transactions WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  def merchant()
    sql = "SELECT * FROM merchants m
          INNER JOIN transactions t
          ON t.merchant_id = m.id
          WHERE m.id = #{@merchant_id};"
    results = SqlRunner.run(sql)
    return Merchant.new(results.first)
  end

  def tag()
    sql = "SELECT * FROM tags tg
          INNER JOIN transactions t
          ON t.tag_id = tg.id
          WHERE tg.id = #{@tag_id};"
    results = SqlRunner.run(sql)
    return Tag.new(results.first)
  end

  def self.total_spent()
    sql = "SELECT SUM(value)
      FROM transactions;"
    total = SqlRunner.run(sql)
    return total[0]['sum']
  end

  def self.budget()
    return 1000.to_i()
  end

  def self.progress_bar()
    progress_bar =  (total_spent().to_f / budget().to_f) * 100
    return progress_bar.to_i
  end

  def self.warning()
    if total_spent().to_i <= budget().to_i
      return "You are under budget"
    elsif total_spent().to_i >= budget().to_i
      return "You are over budget"
    else
      return "Budget not set"
    end
  end

  def format_date()
    formatted_date = Date.parse(@date_of_transaction)
    return "#{formatted_date.strftime('%a %d %b %Y')}"
  end

  def self.list_months()

    months = [
      {
        name: "January",
        number: 1
      },
      {
        name: "February",
        number: 2
      },
      {
        name: "March",
        number: 3
      },
      {
        name: "April",
        number: 4
      },
      {
        name: "May",
        number: 5
      },
      {
        name: "June",
        number: 6
      },
      {
        name: "July",
        number: 7
      },
      {
        name: "August",
        number: 8
      },
      {
        name: "September",
        number: 9
      },
      {
        name: "October",
        number: 10
      },
      {
        name: "November",
        number: 11
      },
      {
        name: "December",
        number: 12
      }
    ]

  end

  def self.all_by_month(month)
    sql = "SELECT * FROM transactions
    WHERE EXTRACT (month from date_of_transaction)=#{month};"
    transactions = SqlRunner.run(sql)
    result = transactions.map{|transaction| Transaction.new(transaction)}
    return result
  end

  def self.days_to_payday()
    days_in_month = 31
    current_month = Date.today().mon()

    if (current_month == 1 ||
      current_month == 3 ||
      current_month == 5 ||
      current_month == 7 ||
      current_month == 8 ||
      current_month == 10 ||
      current_month == 12)
    days_in_month = 31
    else
    days_in_month = 30
    end

    return days_in_month -= Date.today().mday()
  end

end
require_relative('../db/sql_runner')
require_relative('./merchant')
require_relative('./tag')

class Transaction

  attr_accessor :id, :item, :value, :merchant_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i()
    @item = options['item']
    @value = options['value'].to_i()
    @merchant_id = options['merchant_id'].to_i()
    @tag_id = options['tag_id'].to_i()
  end

  def save()
    sql = "INSERT INTO transactions (item, value, merchant_id, tag_id)
    VALUES ('#{@item}', #{@value}, #{merchant_id}, #{tag_id}) RETURNING *;"
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

  def update(options)
    sql = "UPDATE tags SET (item, value, merchant_id, tag_id) = ('#{@item}', #{@value}, #{merchant_id}, #{tag_id}) WHERE id = #{@id};"
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

end
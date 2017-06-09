require_relative('../db/sql_runner')

class Merchant

  attr_accessor :id, :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO merchants (name)
    VALUES ('#{@name}') RETURNING *;"
    merchant_data = SqlRunner.run(sql)
    @id = merchant_data.first['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM merchants;"
    merchants = SqlRunner.run(sql)
    result = merchants.map{|merchant| Merchant.new(merchants)}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM merchants WHERE id = #{id};"
    merchant = SqlRunner.run(sql)
    result = Merchant.new(merchant.first)
    return result
  end

  def update()
    sql = "UPDATE merchants SET (name) = ('#{@name}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM merchants WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM students;"
    SqlRunner.run(sql)
  end

end
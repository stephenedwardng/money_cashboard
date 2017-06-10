require_relative('../db/sql_runner')

class Tag

  attr_accessor :id, :type

  def initialize(options)
    @id = options['id'].to_i
    @type = options['type']
  end

  def save()
    sql = "INSERT INTO tags (type)
    VALUES ('#{@type}') RETURNING *;"
    tag_data = SqlRunner.run(sql)
    @id = tag_data.first['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM tags;"
    tags = SqlRunner.run(sql)
    result = tags.map{|tag| Tag.new(tag)}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = #{id};"
    tag = SqlRunner.run(sql)
    result = Tag.new(tag.first)
    return result
  end

  def update(options)
    sql = "UPDATE tags SET (type) = ('#{@type}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tags WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM tags;"
    SqlRunner.run(sql)
  end

end
require_relative "user"
require_relative "cart"

class Customer < User #Userが親クラス
  attr_reader :cart #カートを読み込む

  def initialize(name)
    super(name) # superの役割について確認したい場合は[https://diver.diveintocode.jp/curriculums/2360]のテキストを参考にしてください。
    @cart = Cart.new(self) # Customerインスタンスは生成されると、自身をオーナーとするカートを持ちます。
  end

end

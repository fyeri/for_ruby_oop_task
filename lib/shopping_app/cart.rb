require_relative "item_manager"
require_relative "ownable"

class Cart
  include ItemManager
  include Ownable

  def initialize(owner) #空のカートを用意する
    self.owner = owner
    @items = []
  end

  def items #選んだアイテムをitemsに格納
    # Cartにとってのitemsは自身の@itemsとしたいため、ItemManagerのitemsメソッドをオーバーライドします。
    # CartインスタンスがItemインスタンスを持つときは、オーナー権限の移譲をさせることなく、自身の@itemsに格納(Cart#add)するだけだからです。
    @items
  end

  def add(item) #アイテムを追加
    @items << item
  end

  def total_amount #合計金額
    @items.sum(&:price) #アイテムに対してプライスメソッドを呼び出す？
  end

  def check_out #チェックアウト 購入を確定するとメソッド実行
    return if owner.wallet.balance < total_amount
  # ## 要件
  #   - カートの中身（Cart#items）のすべてのアイテムの購入金額が、カートのオーナーのウォレットからアイテムのオーナーのウォレットに移されること
 
    self.owner.wallet.withdraw(total_amount)
    seller = @items[0].owner
    seller.wallet.deposit(total_amount)
  #   - カートの中身（Cart#items）のすべてのアイテムのオーナー権限が、カートのオーナーに移されること。
    customer = self.owner
    @items.map do |item|
    item.owner = customer
    end
  #   - カートの中身（Cart#items）が空になること。
    items.clear

  # ## ヒント
  #   - カートのオーナーのウォレット ==> self.owner.wallet
  #   - アイテムのオーナーのウォレット ==> item.owner.wallet
  #   - お金が移されるということ ==> (？)のウォレットからその分を引き出して、(？)のウォレットにその分を入金するということ
  #   - アイテムのオーナー権限がカートのオーナーに移されること ==> オーナーの書き換え(item.owner = ?) 
  end

end

class BeerSong
  def self.verse(num)
    match_verse(num)
  end

  def self.verses(up_to_num, from_num)
      lyrics = []
      up_to_num.downto(from_num) do |verse|
        lyrics << match_verse(verse)
      end
      lyrics.join("\n")
  end

  def self.match_verse(num)
    case num
    when 0
      then "No more bottles of beer on the wall, no more bottles of beer.\n" \
        "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    when 1
      "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    when 2
      "2 bottles of beer on the wall, 2 bottles of beer.\n" \
      "Take one down and pass it around, 1 bottle of beer on the wall.\n"
    else
      "#{num} bottles of beer on the wall, #{num} bottles of beer.\n" \
      "Take one down and pass it around, #{num - 1} bottles of beer on the wall.\n"
    end
  end

  def self.lyrics
    verses(99,0)
  end
end

BeerSong.verse(99)
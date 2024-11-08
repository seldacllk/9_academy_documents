import java.util.*;

public class Handler {

    public static String paragraphReverser(String paragraph){
        // Paragrafı cümlelere ayır (nokta, ünlem veya soru işaretine göre)
        PriorityQueue<Character> punctuationQueue = extractPunctuations(paragraph);
        String[] sentences = paragraph.split("[.!?;:\"]");

        // Cümleleri listeye çevir
        List<String> sentenceList = Arrays.asList(sentences);
        List<String> reversedSentenceList = new ArrayList<String>();
        for (int i = 0; i < sentenceList.size(); i++) {
            //cümlelerin her birini kendi içinde tersine çevir
            reversedSentenceList.add(sentenceReverser(sentenceList.get(i)));
        }
        //tersine çevrilmiş cümleleri paragraf içinde tersine sırala
        Collections.reverse(reversedSentenceList);

        // Cümleleri tekrar birleştir
        String reversedParagraph ="";
        for (String reversedSentence : reversedSentenceList) {
            reversedParagraph = reversedParagraph + reversedSentence + Character.toString(punctuationQueue.remove())+" ";
        }
        return reversedParagraph;
    }

    public static String sentenceReverser(String sentence) {
        sentence= sentence.replaceAll("[.!?;:\"]", "");
        // Cümleyi boşluk karakterine göre kelimelere ayır
        List<String> words = Arrays.asList(sentence.split(" "));
        List<String> clearedWords= new ArrayList<String>();
        for (String word : words) {
            clearedWords.add(word.replaceAll(" ", ""));

        }
        // Kelimeleri ters sıraya çevir
        Collections.reverse(clearedWords);

        // Ters çevrilmiş kelimeleri tekrar birleştir
        return String.join(" ", clearedWords);
    }

    private static PriorityQueue<Character> extractPunctuations(String sentence) {
        // List to store the punctuation marks
        PriorityQueue<Character> punctuationList = new PriorityQueue<>();

        // Define a set of punctuation marks to look for
        String punctuationMarks = "[.!?;:\"]";

        // Iterate over each character in the sentence
        for (char c : sentence.toCharArray()) {
            // If the character is a punctuation mark, add it to the list
            if (punctuationMarks.indexOf(c) != -1) {
                punctuationList.add(c);
            }
        }

        return punctuationList;
    }
    public static int vowelCounter(String string) {
        int count = 0;
        ArrayList<Character> vowels = new ArrayList<Character>();
        vowels.addAll(Arrays.asList('a','e','ı','i','o','ö','u','ü'));
        for (int i = 0; i < string.length(); i++) {
            if (vowels.contains(string.charAt(i))) {
                count++;
            }

        }
        return count;
    }

    public static HashMap<Character, Integer> countAllLetters(String string){
        HashMap<Character, Integer> letterMap = new HashMap<>();
        string = string.toLowerCase();
        string = string.replaceAll(" ", "");
        // Her harfi kontrol et ve harf sıklıklarını hesapla
        for (char letter : string.toCharArray()) {
            if (letterMap.containsKey(letter)) {
                // Eğer harf daha önce eklenmişse, değerini 1 artır
                letterMap.put(letter, letterMap.get(letter) + 1);
            } else {
                // Eğer harf daha önce yoksa, değeri 1 olarak ekle
                letterMap.put(letter, 1);
            }
        }
        return letterMap;
    }

    private static boolean isPrime(int number) {
        if (number <= 1) {
            return false;
        }
        for (int i = 2; i <= Math.sqrt(number); i++) {
            if (number % i == 0) {
                return false;
            }
        }
        return true;
    }

    // n'inci asal sayıyı bulan metod
    public static int FindNthPrime(int n) {
        int counter = 0;
        int number = 1;

        while (counter < n) {
            number++;  // Her adımda sayıyı bir artırıyoruz
            if (isPrime(number)) {
                counter++;  // Eğer asal ise sayacı bir artırıyoruz
            }
        }

        return number;  // n'inci asal sayıyı döndürüyoruz
    }
}

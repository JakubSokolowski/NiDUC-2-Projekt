Zadanie Projektowe na przedmiot Niezależność i Diagnostyka Układów Cyfrowych 2

Projekt ten ma za zadanie zaimplementować symulacje przesyłania wiadomości i wykrywania błędów które mogły nastąpić podczas transmisji.
Jako wiadomości będziemy przesyłać łańcuchy znaków i obrazy (z góry ustalone i generowane losowo) które będą przekazywane do funkcji symulującej transmisje. Funkcja ta będzie z różnym prawdopodobieństwem i w różnym stopniu modyfikowała wiadomości. Następnie wiadomosć wysłana i odebrana będą porównywane za pomocą różnych algorytmów. Porównywane też będą rezultaty tych algorytmów - które wykryją a które nie wykryją zmodyfikowania wiadomości.

W programie wykorzystano następujące algorytmy wykrywania błędów :

1. Kontola parzystości (bit parzystości) - polega na dodawaniu do wysłanej wiadomości bitu kontrolnego, który przyjmuje wartość 1, gdy liczba jednynek w przesłanej wiadomości jest nieparzysta, lub 0 gdy jest parzysta
                                           
2. Cykliczny kod nadmiarowy (Cyclic Redundancy Check, CRC) - system sum kontrolnych, n-bitowy cykliczny kod nadmiarowy (n-bitowy CRC) definiuje się jako resztę z dzielenia ciągu danych przez (n+1)-bitowy dzielnik CRC, zwany również wielomianem CRC

3. Sumy kontrolne z wykorzystanie SHA-512 (Secure Hash Algorithm) - algorytm kryptograficzny, który z ciągu danych o dowolnej długości generuje 512 bitowy skrót (sumę kontrolną). 


Harmonogram Projektu:

24.04.2017 - symulacja wysyłania i zaszumiania wiadomości, sprawdzanie poprawności za pomocą CRC32, wysyłanie prośby o ponowne
             przesłanie   
             
08.05.2017 - dodanie sprawdzania bitu parzystości i sumy kontrolnej SHA-1, zmiany prośby o powtórzenie na 3 bitowy kod powtarzalny,                    detekcja i korekcja prośby o powtórzenie

22.05.2017 - podział informacji na bloki, wykorzystanie SR ARQ

05.06.2017 - badania statystyczne detekcji zmiany wiadomości

19.06.2017 - prezentacja projektu

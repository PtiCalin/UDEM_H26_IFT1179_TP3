
// Fait par Charles Séguin

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace TP3_Partie1
{
    internal class Program
    {
        static int initialiserAvecFichier(Pays[] tab)
        {
            if (tab == null) return -1;

            int nbrPays = 0;
            string ligne;
            string[] elemsLigne = new string[5];
            int code, superficie, population;
            Pays nouvPays;

            StreamReader sr = File.OpenText("Nations.txt");
            try
            {
                while ((ligne = sr.ReadLine()) != null)
                {
                    if (nbrPays >= tab.Length)
                    {
                        break;
                    }

                    elemsLigne[0] = ligne.Substring(0, 1);
                    elemsLigne[1] = ligne.Substring(1, 35).Trim();
                    elemsLigne[2] = ligne.Substring(36, 20).Trim();
                    elemsLigne[3] = ligne.Substring(56, 14).Trim();
                    elemsLigne[4] = ligne.Substring(70, 15).Trim();
                    if ((!int.TryParse(elemsLigne[0], out code)) ||
                        (!int.TryParse(elemsLigne[3], out superficie)) ||
                        (!int.TryParse(elemsLigne[4], out population)))
                    {
                        continue;
                    }

                    nouvPays = new Pays(code, elemsLigne[1], elemsLigne[2], superficie, population);
                    tab[nbrPays] = nouvPays;
                    nbrPays++;
                }
            }
            finally 
            { 
                sr.Close(); 
            }

            return nbrPays;
        }

        static void CreeFichierPourPays(Pays[] tab, int nbrPays, int code, string nomFichier)
        {
            StreamWriter sw = File.CreateText(nomFichier);
            try
            {
                for (int i = 0; i < nbrPays; i++)
                {
                    if (tab[i].codeContinent == code)
                    {
                        sw.WriteLine(tab[i].ToString());
                    }
                }
            }
            finally
            {
                sw.Close();
            }
        }

        static void Main(string[] args)
        {
            Pays[] paysArray = new Pays[250];
            int nbrPays = initialiserAvecFichier(paysArray);

            // 1. Afficher les nombre de pays lus
            Console.WriteLine("Nombre de pays lus : " + nbrPays);

            // 2. Afficher les 15 premiers pays lus
            for (int i = 0; i < nbrPays; i++)
            {
                if (i >= 15) break;
                Console.WriteLine(paysArray[i].ToString());
            }

            // 3. Modifications et affichage des 15 premiers pays a nouveau

            // 3a. Modifications
            string[] nomPays = new string[nbrPays];
            for (int i = 0; i < nbrPays; i++)
            {
                nomPays[i] = paysArray[i].nom;
            }

            paysArray[Array.IndexOf(nomPays, "RUSSIE")].codeContinent = 5;
            paysArray[Array.IndexOf(nomPays, "CHINE")].captitale = "PEKIN";
            paysArray[Array.IndexOf(nomPays, "ALLEMAGNE")].population *= 10;

            // 3b. Affichage
            Console.WriteLine("\n15 premiers pays apres modifications :");
            for (int i = 0; i < nbrPays; i++)
            {
                if (i >= 15) break;
                Console.WriteLine(paysArray[i].ToString());
            }

            // 4. Afficher les pays avec le nom identique a leur capitale
            Console.WriteLine("\nPays avec le nom identique a leur capitale :");
            for (int i = 0; i < nbrPays; i++)
            {
                if (paysArray[i].nom == paysArray[i].captitale)
                {
                    Console.WriteLine(paysArray[i].ToString());
                }
            }

            // 5. Afficher les pays de continents specifiques avec la plus petite densite de population
            int minDensiteEurope = int.MaxValue;    // Europe : code continent 5
            int indiceMinEurope = 0;
            int minDensiteOceanie = int.MaxValue;   // Oceanie : code continent 4
            int indiceMinOceanie = 0;
            int densite = 0;
            for (int i = 0; i < nbrPays; i++)
            {
                if (paysArray[i].superficie == 0) continue; // Eviter la division par zero

                if (paysArray[i].codeContinent == 5) // Europe
                {
                    densite = paysArray[i].population / paysArray[i].superficie;
                    if (densite < minDensiteEurope)
                    {
                        indiceMinEurope = i;
                        minDensiteEurope = densite;
                    }
                }
                else if (paysArray[i].codeContinent == 4) // Oceanie
                {
                    densite = paysArray[i].population / paysArray[i].superficie;
                    if (densite < minDensiteOceanie)
                    {
                        indiceMinOceanie = i;
                        minDensiteOceanie = densite;
                    }
                }
            }
            Console.WriteLine("\nPays d'Europe avec la plus petite densite de population : " + paysArray[indiceMinEurope].ToString());
            Console.WriteLine("\nPays d'Oceanie avec la plus petite densite de population : " + paysArray[indiceMinOceanie].ToString());

            // 6. Afficher les pays de continents specifiques avec la plus grande population
            int maxPopulationAmerique = 0;    // Amerique : code continent 2
            int indiceMaxAmerique = 0;
            int maxPopulationEurope = 0;      // Europe : code continent 5
            int indiceMaxEurope = 0;

            for (int i = 0; i < nbrPays; i++)
            {
                if (paysArray[i].codeContinent == 2) // Amerique
                {
                    if (paysArray[i].population > maxPopulationAmerique)
                    {
                        indiceMaxAmerique = i;
                        maxPopulationAmerique = paysArray[i].population;
                    }
                }
                else if (paysArray[i].codeContinent == 5) // Europe
                {
                    if (paysArray[i].population > maxPopulationEurope)
                    {
                        indiceMaxEurope = i;
                        maxPopulationEurope = paysArray[i].population;
                    }
                }
            }

            // 7. Determiner et afficher les informations...
            Console.WriteLine("\nPays dont le nom commence par une voyelle :");
            for (int i = 0; i < nbrPays; i++)
            {
                char premiereLettre = paysArray[i].nom.ToUpper()[0];
                if ("AEIOUY".Contains(premiereLettre))
                {
                    Console.WriteLine(paysArray[i].ToString());
                }
            }

            Console.WriteLine("\nPays d'Amerique dont la capitale contient le plus de lettres alphabetiques");
            int maxLettresCapitalesAmerique = 0;
            int lettresAlphabetiques = -1;
            int indiceMaxCapAmerique = 0;
            for (int i = 0; i < nbrPays; i++)
            {
                if (paysArray[i].codeContinent == 2) // Amerique
                {
                    for (int j = 0; j < paysArray[i].captitale.Length; j++)
                    {
                        if (char.IsLetter(paysArray[i].captitale[j]))
                        {
                            lettresAlphabetiques++;
                        }
                    }
                    if (lettresAlphabetiques > maxLettresCapitalesAmerique)
                    {
                        indiceMaxCapAmerique = i;
                        maxLettresCapitalesAmerique = lettresAlphabetiques;
                    }
                }
            }

            if (indiceMaxCapAmerique > -1)
            {
                Console.WriteLine(paysArray[indiceMaxCapAmerique].ToString());
            }

            // 8. Tri des pays par ordre alphabetique de leur nom et affichage
            Array.Sort(nomPays, paysArray);
            Console.WriteLine("\nPays tries par ordre alphabetique de leur nom :");
            for (int i = 0; i < nbrPays; i++)
            {
                Console.WriteLine(paysArray[i].ToString());
            }

            // 9. Chercher avec Array.BinarySearch puis afficher les pays suivants : "Chili", "France", "Chine", "Mexique"
            Console.WriteLine("\nRecherche de pays avec Array.BinarySearch :");
            Array.Sort(nomPays);
            int indexRecherchePays = -1;
            indexRecherchePays = Array.BinarySearch(nomPays, "CHILI");
            if (indexRecherchePays >= 0)
                Console.WriteLine("Pays trouve : " + paysArray[indexRecherchePays].ToString());
            else
                Console.WriteLine("Pays non trouve : Chili");

            indexRecherchePays = Array.BinarySearch(nomPays, "FRANCE");
            if (indexRecherchePays >= 0)
                Console.WriteLine("Pays trouve : " + paysArray[indexRecherchePays].ToString());
            else
                Console.WriteLine("Pays non trouve : France");

            indexRecherchePays = Array.BinarySearch(nomPays, "CHINE");
            if (indexRecherchePays >= 0)
                Console.WriteLine("Pays trouve : " + paysArray[indexRecherchePays].ToString());
            else
                Console.WriteLine("Pays non trouve : Chine");

            indexRecherchePays = Array.BinarySearch(nomPays, "MEXIQUE");
            if (indexRecherchePays >= 0)
                Console.WriteLine("Pays trouve : " + paysArray[indexRecherchePays].ToString());
            else
                Console.WriteLine("Pays non trouve : Mexique");

            // 10. Creer fichier "Europe.txt" et "Asie.txt" pour les pays d'Europe et d'Asie respectivement
            CreeFichierPourPays(paysArray, nbrPays, 5, "Europe.txt");
            CreeFichierPourPays(paysArray, nbrPays, 3, "Asie.txt");
        }
    }
}

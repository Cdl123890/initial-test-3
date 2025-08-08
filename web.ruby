import React from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { useState, useEffect } from "react";

export default function LifestyleDashboard() {
  const [quote, setQuote] = useState("");
  const [recipe, setRecipe] = useState(null);

  useEffect(() => {
    fetch("https://api.quotable.io/random")
      .then((res) => res.json())
      .then((data) => setQuote(data.content));

    fetch("https://api.spoonacular.com/recipes/random?apiKey=YOUR_API_KEY")
      .then((res) => res.json())
      .then((data) => setRecipe(data.recipes[0]));
  }, []);

  return (
    <div className="p-6 grid gap-6">
      <h1 className="text-3xl font-bold">Lifestyle Dashboard</h1>

      <Tabs defaultValue="daily" className="w-full">
        <TabsList>
          <TabsTrigger value="daily">Daily</TabsTrigger>
          <TabsTrigger value="fitness">Fitness</TabsTrigger>
          <TabsTrigger value="nutrition">Nutrition</TabsTrigger>
        </TabsList>

        <TabsContent value="daily">
          <Card>
            <CardContent className="p-4">
              <h2 className="text-xl font-semibold mb-2">Daily Quote</h2>
              <p>{quote || "Loading..."}</p>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="fitness">
          <Card>
            <CardContent className="p-4">
              <h2 className="text-xl font-semibold mb-2">Fitness Tips</h2>
              <ul className="list-disc pl-6">
                <li>10-minute morning stretch</li>
                <li>Bodyweight circuit: 3 rounds</li>
                <li>Evening walk - 30 minutes</li>
              </ul>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="nutrition">
          <Card>
            <CardContent className="p-4">
              <h2 className="text-xl font-semibold mb-2">Recipe of the Day</h2>
              {recipe ? (
                <div>
                  <p className="font-bold">{recipe.title}</p>
                  <img src={recipe.image} alt={recipe.title} className="w-full max-w-md rounded mt-2" />
                  <p className="mt-2">Ready in {recipe.readyInMinutes} minutes</p>
                </div>
              ) : (
                <p>Loading recipe...</p>
              )}
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}

import tkinter as tk
from tkinter import ttk, messagebox


def calculate_bmi(height, weight):
    height /= 100
    return float(f"{(weight / height ** 2):.1f}")


def analyze_result(height, weight):
    text_messages = {
        'underweight': {'message': 'Your BMI indicates that you are underweight.',
                        'advice': "Focus on nutrient-rich foods such as nuts, whole grains, avocados, and lean proteins."},
        'normal weight': {'message': 'Your BMI is within the normal range.',
                          'advice': 'Continue with your balanced diet, ensuring you are getting a mix of fruits, vegetables, whole grains, and proteins.'},
        'overweight': {'message': 'Your BMI suggests you are slightly above the recommended weight for your height.',
                       'advice': 'Gradually introduce more fruits, vegetables, and whole grains into your diet while reducing high-calorie and sugary foods.'},
        'obesity': {'message': 'Your BMI falls into the obese category.',
                    'advice': 'Focus on reducing calorie intake in a healthy way, avoiding crash diets.'},
        'extreme obesity': {'message': 'Your BMI indicates that you are extremely obese.',
                            'advice': 'Professional medical advice is strongly recommended. This might include dieticians, doctors, or weight-loss specialists.'}
    }

    result = calculate_bmi(float(height), float(weight))
    category = ''
    if 0 <= result <= 18.4:
        category = 'underweight'
    elif 18.4 < result <= 24.9:
        category = 'normal weight'
    elif 24.9 < result <= 29.9:
        category = 'overweight'
    elif 29.9 < result <= 39.9:
        category = 'obesity'
    elif 39.9 < result:
        category = 'extreme obesity'

    message = text_messages[category]['message']
    advice = text_messages[category]['advice']

    return result, message, advice


def initialize_app():
    global main_view_container, button_style



    def generate_result_window(bmi, message, advice):

        result_container = tk.Frame(root, bg='#87CEEB')
        result_container.grid(row=0, column=0, sticky='nsew')
        switch_view(main_view_container, result_container)
        for i in range(5):
            result_container.grid_rowconfigure(i, weight=1)

        for i in range(5):
            result_container.grid_columnconfigure(i, weight=1)

        result_label = ttk.Label(result_container, background='#87CEEB', font=('Helvetica', 25, 'bold'),
                                  text=f'Your BMI is {bmi}.')
        result_label.grid(row=1, column=2, columnspan=5, padx=10, pady=10, sticky='s')

        message_label = ttk.Label(result_container, background='#87CEEB', font=('Helvetica', 15), text=message, wraplength=700)
        message_label.grid(row=2, column=2, columnspan=5, padx=10, pady=10, sticky='s')

        advice_heading = ttk.Label(result_container, background='#87CEEB', font=('Helvetica', 12, 'italic'), text='Advice:', wraplength=700)
        advice_heading.grid(row=3, column=0, columnspan=5, padx=10, pady=10, sticky='s')

        advice_label = ttk.Label(result_container, background='#87CEEB', font=('Helvetica', 12, 'italic'), text=advice, wraplength=700)
        advice_label.grid(row=4, column=2, columnspan=5, padx=10, pady=10, sticky='nw')

        reset_button = ttk.Button(result_container, text='Reset', command=lambda: switch_view(result_container, main_view_container))
        reset_button.grid(row=5, column=3, padx=10, pady=10)

        switch_view(main_view_container, result_container)

    def switch_view(old, new):
        if new == main_view_container:
            for widget in main_view_container.winfo_children():
                if widget.winfo_class() == 'TEntry':
                    widget.delete(0, tk.END)

        old.grid_remove()
        new.grid()

    def on_click():
        try:
            height_value = float(height_entry.get())
            weight_value = float(weight_entry.get())
            bmi, message, advice = analyze_result(height_value, weight_value)
            generate_result_window(bmi, message, advice)
        except ValueError:
            messagebox.showerror('Input Error', "Please enter valid numbers for weight and height.")

    root = tk.Tk()
    root.title('BMI Calculator')
    root.geometry('720x550')
    root.resizable(True, True)

    root.grid_rowconfigure(0, weight=1)
    root.grid_columnconfigure(0, weight=1)

    main_view_container = tk.Frame(root, bg='#87CEEB')
    main_view_container.grid(row=0, column=0, sticky='nsew')

    main_view_container.grid_rowconfigure((0, 4), weight=1)
    main_view_container.grid_columnconfigure((0, 4), weight=1)

    button_style = ttk.Style(root)
    button_style.configure('TButton', font=('calibri', 8, 'bold'), borderwidth='1', background='white')
    button_style.map('TButton', foreground=[('active', '!disabled', 'white')], background=[('active', 'gray')])

    heading_label = ttk.Label(main_view_container, background='#87CEEB', font=('Helvetica', 25), text='GET YOUR FREE BMI ANALYSIS')
    heading_label.grid(row=0, column=0, columnspan=5, padx=10, pady=10)

    weight_label = ttk.Label(main_view_container, background='#87CEEB', font=('Helvetica', 12), text='Enter your weight (kg):')
    weight_label.grid(row=1, column=1, padx=10, pady=10, sticky='e')
    weight_entry = ttk.Entry(main_view_container, width=12)
    weight_entry.grid(row=1, column=2, padx=10, pady=10, sticky='w')

    height_label = ttk.Label(main_view_container, background='#87CEEB',font=('Helvetica', 12), text='Enter your height (cm):')
    height_label.grid(row=2, column=1, padx=10, pady=10, sticky='e')
    height_entry = ttk.Entry(main_view_container, width=12)
    height_entry.grid(row=2, column=2, padx=10, pady=10, sticky='w')

    calculate_button = ttk.Button(main_view_container, text='Calculate BMI', command=on_click, width=12)
    calculate_button.grid(row=3, column=2, padx=10, pady=10)

    root.mainloop()


main_view_container = ''

initialize_app()
